//
//  DatabaseManger.swift
//  Fitness
//
//  Created by Raghav Dwivedi on 9/2/2024.
//

import UIKit
import CoreData

class DataBaseManager: NSObject {
    
    var excercises: [NSManagedObject] = []
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addRow( reps:Double, sets:Double, name:String, category:String, weight:Float, sel:Bool) {
        // set the core data to access the Student Entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)
        let excercise = NSManagedObject(entity: entity!, insertInto: managedContext)
        excercise.setValue(name, forKey: "name")
        excercise.setValue(reps,  forKey: "reps")
        excercise.setValue(sets, forKey: "sets")
        excercise.setValue(category, forKey: "category")
        excercise.setValue(weight, forKey: "weight")
        excercise.setValue(sel, forKey: "selected")
        
        
        
        do {
            try managedContext.save()
            excercises.append(excercise)
            
               //  showMessage("Information is added")
        }
        catch  {
              // showMessage("Error While Adding to Core Data")
        }
        
    }
    
    func getRep(name: String) -> Double {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return 0.0 }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            
            
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        var temp: Double = (excercises[0].value(forKey: "reps") as? Double)!
        return temp
        
        }
    
    func getWeight(name: String) -> Float {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return 0.0 }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            
            
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        var temp: Float = (excercises[0].value(forKey: "weight") as? Float)!
        return temp
        }
    
    func getSet(name: String) -> Double {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return 0.0 }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            
            
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        var temp: Double = (excercises[0].value(forKey: "sets") as? Double)!
        return temp
        
        }
    

    
    
    func changeSel(category: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            
            
            fetchRequest.predicate = NSPredicate(format: "category == %@", category)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        
        var i: Int = 0
        for ex in excercises {
            ex.setValue(true, forKey: "selected")
            i += 1;
            if(i == 6) {
                break
            }
        }

    }
    
    func retSet(category: String) -> String {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            
            
            fetchRequest.predicate = NSPredicate(format: "category == %@", category)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        
        var msg : String = ""
        var count = 0
        for ex in excercises {
            var temp: String = (ex.value(forKey: "sets") as? String)!
            msg = msg + temp + " "
        }
        return msg
    }
    
    func retRep(category: String) -> String {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            
            
            fetchRequest.predicate = NSPredicate(format: "category == %@", category)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        
        var msg : String = ""
        var count = 0
        for ex in excercises {
            var temp: String = (ex.value(forKey: "reps") as? String)!
            msg = msg + temp + " "
        }
        return msg
    }
    
    func retWeight(category: String) -> String {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            
            
            fetchRequest.predicate = NSPredicate(format: "category == %@", category)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        
        var msg : String = ""
        var count = 0
        for ex in excercises {
            var temp: String = (ex.value(forKey: "weight") as? String)!
            msg = msg + temp + " "
        }
        return msg
    }
    
    func retName(category: String) -> String {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            
            
            fetchRequest.predicate = NSPredicate(format: "category == %@", category)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        
        var msg : String = ""
        var count = 0
        for ex in excercises {
            var temp: String = (ex.value(forKey: "name") as? String)!
            msg = msg + temp + " "
        }
        return msg
    }
    
    
    func retCat(category: String) -> [String] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return [""]}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            
            
            fetchRequest.predicate = NSPredicate(format: "category == %@", category)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        
        var msg : [String] = []
        var count = 0
        for ex in excercises {
            var temp: String = (ex.value(forKey: "name") as? String)!
            msg.append(temp)
        }
        return msg
        
    }
    
    func changeVal(name: String, sets: Double, weight: Float, reps: Double) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("St4p 0")
            return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        do {
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            print("Step 1")
            excercises  = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("not found")
        }
        print("Working")
        excercises[0].setValue(weight, forKey: "weight")
        excercises[0].setValue(reps, forKey: "reps")
        excercises[0].setValue(sets, forKey: "sets")
        
    }
    
    
    func delName(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
            
        do {
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
             fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            excercises  = try managedContext.fetch(fetchRequest)
            for pizza in excercises {
                print("Deleted")
                managedContext.delete(pizza)
            }
        }
        catch {
        }
        do {
            try managedContext.save()
        }
        catch {
            
        }
    }
    
    
    
    func retrieveRows(names: String) -> [String] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return [""]}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        if names == "all" {
            do {
                   let name = names
                
                  // fetchRequest.predicate = NSPredicate(format: "name == %@", name)
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                excercises  = try managedContext.fetch(fetchRequest)
            }
            catch {
                print("not found")
            }
        }
        else {
            do {
                let name = names
                
                fetchRequest.predicate = NSPredicate(format: "category == %@", name)
                 fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
                excercises  = try managedContext.fetch(fetchRequest)
            }
            catch {
                print("not found")
            }
            
        }
        
        var msg : [String] = []
        
        var count = 0
        for pizza in excercises {
            
            var temp: String = ""
            temp = (pizza.value(forKeyPath: "category") as? String)!
            temp = temp + "  " + (pizza.value(forKeyPath: "name") as? String)!  + "  "
            
            var numtemp: Double = (pizza.value(forKey: "sets") as? Double)!
            temp = temp + String(numtemp) + "  "
            numtemp = (pizza.value(forKey: "reps") as? Double)!
            temp = temp + String(numtemp) + "  "
            
            var wetemp: Float = (pizza.value(forKey: "weight") as? Float)!
            temp = temp + String(wetemp)
            
            
            
            msg.append(temp)
            
            count += 1
        }
        //  msg = String(count)
        return msg
    }
    
}


