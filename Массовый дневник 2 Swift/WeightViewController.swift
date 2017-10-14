//
//  WeightViewController.swift
//  Массовый дневник Swift
//
//  Created by Admin on 28.09.17.
//  Copyright © 2017 Bonaventura. All rights reserved.
//

import UIKit
import os.log

class WeightViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var date: String! = ""
    var weight: Float! = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightText.delegate = self
        
        setDate() {result, error in
            DispatchQueue.main.async {
                guard let text = result else {return}
                self.dateLabel.text = text
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        date = dateLabel.text
        weight = Float(weightText.text!) ?? 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        weightText.resignFirstResponder()
        return true
    }
    
    func setDate(completion: @escaping (String, Error?)->()) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let date = try self.getDate()
                completion(date, nil)
            } catch let error {
                completion("", error)
            }
        }
    }
    
    func getDate() throws -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        
        let result = formatter.string(from: date)
        if result == "" { throw DateError(error: "failed to get date") }
        return result;
    }
    
    
}
