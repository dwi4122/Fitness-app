//
//  ProgramManager.swift
//  Fitness
//
//  Created by Raghav Dwivedi on 10/2/2024.
//

import UIKit
import CoreData

class ProgramManager: NSObject {
    
    var workouts: [NSManagedObject] = []
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addRow( date: Date, completed: Bool, category: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        let workout = NSManagedObject(entity: entity!, insertInto: managedContext)
        workout.setValue(category, forKey: "category")
        workout.setValue(date,  forKey: "date")
        workout.setValue(completed, forKey: "completed")
        /*
        workout.setValue(sets, forKey: "sets")
        workout.setValue(reps, forKey: "reps")
        workout.setValue(weight, forKey: "weight")
        workout.setValue(exercise, forKey: "exercise")
         */
        
        do {
            try managedContext.save()
            workouts.append(workout)
            
                 print("Information is added")
        }
        catch  {
               print("Error While Adding to Core Data")
        }
        
    }
    
    func getRow(category: String) {
        
    }
    
   


}
