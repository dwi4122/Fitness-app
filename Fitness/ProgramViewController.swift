//
//  ProgramViewController.swift
//  Fitness
//
//  Created by Raghav Dwivedi on 10/2/2024.
//

import UIKit
import EventKitUI
import EventKit

class ProgramViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var exercise: UITableView!
    
    @IBOutlet weak var daylabel: UILabel!
    var ex_count: Int = 0;
    let eventStore = EKEventStore()
    var count: Int = 0;
    
    @IBOutlet weak var category: UIPickerView!
    
    @IBOutlet weak var date: UIDatePicker!
    var pickcat: [String] = ["Abs", "Legs", "Chest", "Shoulder", "Arms", "Back"]
    
    var exerciseList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch EKEventStore.authorizationStatus(for: EKEntityType.event) {
        case .authorized:
            insertEvent(eventStore)
        case .denied:
            print("Access denied")
        case .notDetermined:
            // If the status is not yet determined the user is prompted to deny or grant access using the requestAccessToEntityType(entityType:completion) method.
            eventStore.requestAccess(to: EKEntityType.event, completion: {(granted, error) in
                if granted {
                    self.insertEvent(self.eventStore)
                } else {
                    print("Access denied")
                }
            })
        default:
            print("Case Default")
        }
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    func setup() {
        let db = DataBaseManager()
        exerciseList = db.retCat(category: pickcat[category.selectedRow(inComponent: 0)])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickcat.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickcat[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        setup()
        
        exercise.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel!.text = exerciseList[indexPath.row]
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ex_count += 1;
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        ex_count -= 1;
        
    }
    
    
    
    
    func insertEvent(_ store: EKEventStore) {
        
        let startDate = date.date
        
        let endDate = startDate.addingTimeInterval(2 * 60 * 60)
        // Create event
        let event = EKEvent(eventStore: store)
        event.calendar = store.defaultCalendarForNewEvents
        var temp: String = pickcat[category.selectedRow(inComponent: 0)]
        temp = temp + " " + "Workout"
        event.title = temp
        event.startDate = startDate
        event.endDate = endDate
        // Save Event in Calendar
        do {
            try store.save(event, span: .thisEvent)
        } catch {
            print("An error occured")
        }
    }
    
    func reset() {
        count += 1
      var msg: String = "Day " + String(count)
        daylabel.text = msg
        if(count > 2) {
            let alertController = UIAlertController(title: "Success", message: "Week program set!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func submit(_ sender: Any) {
        if ex_count < 6 {
            let alertController = UIAlertController(title: "Error", message: "Please select 6 exercises.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        
        let db = DataBaseManager()
        db.changeSel(category: pickcat[category.selectedRow(inComponent: 0)])
        
        
        /*
        var set_msg: String = db.retSet(category: pickcat[category.selectedRow(inComponent: 0)])
        var rep_msg: String = db.retRep(category: pickcat[category.selectedRow(inComponent: 0)])
        var weight_msg: String = db.retWeight(category: pickcat[category.selectedRow(inComponent: 0)])
        var ex_msg: String = db.retName(category: pickcat[category.selectedRow(inComponent: 0)])
        */
        
        let pm = ProgramManager()
        
        pm.addRow(date: date.date, completed: false, category: pickcat[category.selectedRow(inComponent: 0)] )
        insertEvent(eventStore)
        
        
        reset()
        let alertController = UIAlertController(title: "Success", message: "Set more days", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
