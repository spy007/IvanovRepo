//
//  WeightTableViewController.swift
//  Массовый дневник Swift
//
//  Created by Admin on 28.09.17.
//  Copyright © 2017 Bonaventura. All rights reserved.
//

import UIKit
import os.log
import CoreData

class WeightTableViewController: UITableViewController {
    
    var weights: [WeightEntity] = []
    let db = DBMng()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("")
        self.weights = db.get()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weights.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeightTableViewCell
        
        let weight = weights[indexPath.row]
        let weightTuple = (date:weight.date, kg:weight.kg)
        
        do {
            cell.dataLabel.text = try Utils.dateToStr(date: weightTuple.0!)
            cell.weightLabel.text = weightTuple.kg?.description
        } catch {
            fatalError("Failed to convert Date to String: %@")
        }
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    // When navigating from here to another controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "AddItem": break
        case "showDetail":
            guard let weightDetail = segue.destination as? WeightViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedWeightCell = sender as? WeightTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedWeightCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let weight = weights[indexPath.row];
            weightDetail.date = weight.date
            weightDetail.weight = weight.kg
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    // When navigating back here from another controller
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? WeightViewController,
            let date = sourceViewController.date,
            let kg = sourceViewController.weight {
            
            DispatchQueue.global(qos: .background).async {
                let newIndexPath = IndexPath(row: self.weights.count, section: 0)
                let weight = WeightEntity(date: date, kg: kg)
                self.weights.append(weight)
                self.db.save(weightEntity: weight)
                DispatchQueue.main.async {
                    self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
    }
}
