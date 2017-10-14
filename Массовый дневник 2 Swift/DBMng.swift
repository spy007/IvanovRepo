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

class DBMng {
    let entity = "Weight"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    func save(weightEntity: WeightEntity) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: self.entity,
                                                in: managedContext)!
        
        let weight = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        weight.setValue(weightEntity.kg, forKeyPath: "kg")
        weight.setValue(weightEntity.date, forKeyPath: "date")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func get() -> [WeightEntity] {
        let managedContext = appDelegate.persistentContainer.viewContext
        var weights = [WeightEntity]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Weight")
        do {
            let weightsObj = try managedContext.fetch(fetchRequest)
            for w in weightsObj {
                var weight = WeightEntity()
                weight.date = w.value(forKeyPath: "date") as! Date
                weight.kg = w.value(forKeyPath: "kg") as! Float
                weights.append(weight)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return weights
    }
}
