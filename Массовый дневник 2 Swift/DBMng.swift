//
//  DBCreator.swift
//  Массовый дневник 2 Swift
//
//  Created by Admin on 04.10.17.
//  Copyright © 2017 Bonaventura. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBCreator {
    let context: NSManagedObjectContext
    let entity = "Weight"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() {
        context = appDelegate.managedObjectContext
    }
    
    func save(kg: Float!, date: Date) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: self.entity,
                                                in: managedContext)!
        
        let weight = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        weight.setValue(kg, forKeyPath: "kg")
        weight.setValue(date, forKeyPath: "date")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    
    func get() -> [Weight] {
        let managedContext = appDelegate.persistentContainer.viewContext
        var weights = [Weight]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Weight")
        do {
            let weightsObj = try managedContext.fetch(fetchRequest)
            for w in weightsObj {
                let weight = Weight()
                weight.date = w.value(forKeyPath: "date")
                weight.kg = w.value(forKeyPath: "kg")
                
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        
        return weights!
    }
}
