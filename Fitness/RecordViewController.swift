//
//  RecordViewController.swift
//  Fitness
//
//  Created by Raghav Dwivedi on 11/2/2024.
//

import UIKit

class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var day: UILabel!
    let dc = Date()
    
    
    @IBOutlet weak var reps: UIStepper!
    @IBOutlet weak var sets: UIStepper!
    @IBOutlet weak var weight: UISlider!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var repLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    var secondsRemaining = 30
    
    @IBOutlet weak var timer: UILabel!
    var imagePicker: UIImagePickerController!
    
   // @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var exercise: UITableView!
    
    var sel: Int = 0
    
    
    var exerciseList: [String] = ["Test"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = DataBaseManager()
        exerciseList = db.retCat(category: "Chest")
        day.text = dc.formatted(Date.FormatStyle().weekday(.wide))
        let pb = ProgramManager()
        reset()
        
        
        /*
        var dformatter = DateFormatter()
        dformatter.dateFormat = "dd-MM-yyyy HH:mm"
        var d  = Date()
        var strDate = dformatter.string(from: d)
        
        day.text = strDate */
        
    // Do any additional setup after loading the view.
    }
    
    func reset() {
        sets.wraps = true
        sets.minimumValue = 0
        sets.maximumValue = 10
        sets.value = 0
        setLabel.text = String(Int(0))
        reps.wraps = true
        reps.minimumValue = 0
        reps.maximumValue = 20
        reps.value = 0
        repLabel.text = String(Int(0))
        weight.minimumValue = 10
        weight.maximumValue = 200
        weightLabel.text = String(Int(10))

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel!.text = exerciseList[indexPath.row]
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let db = DataBaseManager()
        
        sel = indexPath.row
        var ex: String = exerciseList[indexPath.row]
        var setval: Double = db.getSet(name: ex)
        var repval: Double = db.getRep(name: ex)
        var weightval: Float = db.getWeight(name: ex)
        sets.value = setval
        setLabel.text = String(setval)
        reps.value = repval
        repLabel.text = String(repval)
        weight.value = weightval
        weightLabel.text = String(weightval)
                }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    @IBAction func takePhoto(sender: UIButton) { imagePicker = UIImagePickerController(); imagePicker.delegate = self; imagePicker.sourceType = .camera
      // if no camera
         present(imagePicker, animated: true,
      completion: nil)
        }
    
    @IBAction func setChange(_ sender: UIStepper) {
        let db = DataBaseManager()
        var temp: Int = Int(sets.value)
        
        setLabel.text = String(temp)
        var msg: [String] = db.retCat(category: "Chest")
        var tem: String = ""
        var t: String = String(msg.count)
        tem = tem + "\(t)"
        for m in msg {
            
            tem += " " + m
        }
        
        //output.text = tem
    }
    
    @IBAction func repChange(_ sender: UIStepper) {
        var temp: Int = Int(reps.value)
        repLabel.text = String(temp)
    }
    
    
    @IBAction func weightChange(_ sender: UISlider) {
        var temp: Int = Int(weight.value)
        weightLabel.text = String(temp)
    }
    
    
    @IBAction func rest(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if self.secondsRemaining >= 0 {
                    self.timer.text = ("\(self.secondsRemaining) seconds")
                    self.secondsRemaining -= 1
                } else {
                    Timer.invalidate()
                }
            }
        self.secondsRemaining = 30
       
    }
    
    @IBAction func finset(_ sender: Any) {
            
           change()
        
        let alert = UIAlertController(title: "Success!",
       message: "Select next exercise",
        preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Okay",
       style: UIAlertAction.Style.default, handler:
       nil));
        self.present(alert, animated: true, completion:
       nil);
            
        }
    
    func change() {
        let db = DataBaseManager()
        db.changeVal(name: exerciseList[sel], sets: sets.value, weight: weight.value, reps: reps.value)
    }
    
    

    @IBAction func end(_ sender: Any) {
        let alert = UIAlertController(title: "Success!",
       message: "Workout Complete",
        preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Okay",
       style: UIAlertAction.Style.default, handler:
       nil));
        self.present(alert, animated: true, completion:
       nil);
         
    }
    
    
    func getDayOfWeek(_ date:String, format: String) -> String? {
        
        let weekDays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]

        let formatter  = DateFormatter()
        formatter.dateFormat = format
        guard let myDate = formatter.date(from: date) else { return nil }
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: myDate)
        
        
        return weekDays[weekDay-1]
    }
    

}




