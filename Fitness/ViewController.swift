//
//  ViewController.swift
//  Fitness
//
//  Created by Raghav Dwivedi on 9/2/2024.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var sets: UIStepper!
    @IBOutlet weak var reps: UIStepper!
    //@IBOutlet weak var output: UILabel!
    
    @IBOutlet weak var output: UILabel!
    
    @IBOutlet weak var category: UIPickerView!
    var pickcat: [String] = ["Abs", "Legs", "Chest", "Shoulder", "Arms", "Back"]
    
    @IBOutlet weak var weight: UISlider!
    @IBOutlet weak var setlabel: UILabel!
    
    @IBOutlet weak var weightlabel: UILabel!
    @IBOutlet weak var replabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.category.dataSource = self
        self.category.delegate = self
        reset()
       
                
        
        
       
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1
    }
    
    func reset() {
        sets.wraps = true
        sets.minimumValue = 0
        sets.maximumValue = 10
        sets.value = 0
        setlabel.text = String(Int(0))
        reps.wraps = true
        reps.minimumValue = 0
        reps.maximumValue = 20
        reps.value = 0
        replabel.text = String(Int(0))
        weight.minimumValue = 10
        weight.maximumValue = 200
        weightlabel.text = String(Int(10))
        name.text = " "
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickcat.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickcat[row]
        }
    
    

    @IBAction func save(_ sender: Any) {
        
        let db = DataBaseManager()
        var bool_temp: Bool = false;
        db.addRow(reps: (reps.value), sets: (sets.value), name: name.text!, category: pickcat[category.selectedRow(inComponent: 0)], weight: weight.value, sel: bool_temp)
        reset()
        let alert = UIAlertController(title: "Success!",
       message: "Exercise added",
        preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Okay",
       style: UIAlertAction.Style.default, handler:
       nil));
        self.present(alert, animated: true, completion:
       nil);
         
        
       
        
        
    }
    /*
     // Test function to check if value was added
    // Add Button and name the action ret, add label outlet
    @IBAction func ret(_ sender: Any) {
        
        let db = DataBaseManager()
        var msg: [String] = db.retrieveRows(names: name.text!)
        output.text = msg[0]
    }
     */
    
    
    @IBAction func setChange(_ sender: UIStepper) {
        let db = DataBaseManager()
        var temp: Int = Int(sets.value)
        setlabel.text = String(temp)
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
        replabel.text = String(temp)
    }
    
    
    @IBAction func weightChange(_ sender: UISlider) {
        var temp: Int = Int(weight.value)
        weightlabel.text = String(temp)
    }
    
    
}

