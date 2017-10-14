//
//  WeightTableViewController.swift
//  Массовый дневник Swift
//
//  Created by Admin on 28.09.17.
//  Copyright © 2017 Bonaventura. All rights reserved.
//

import UIKit
import os.log

class WeightTableViewController: UITableViewController {

    var datesSet = [String]()
    var weightsDict = [String:Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let in1 = MyClass()
        in1.i = 1;

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return datesSet.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeightTableViewCell

        let date = Array(datesSet)[indexPath.row]
        os_log("^^^^^ date=%@", date)
        cell.dataLabel.text = date
        cell.weightLabel.text = String(describing: weightsDict[date])

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
            if let sourceViewController = sender.source as? WeightViewController,
                let date = sourceViewController.date,
                let weight = sourceViewController.weight {
                
                DispatchQueue.global(qos: .background).async {
                    let newIndexPath = IndexPath(row: self.datesSet.count, section: 0)
                    self.datesSet.append(date)
                    self.weightsDict[date] = weight
                    DispatchQueue.main.async {
                        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                    }
                }
        }
    }
}
