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
    @IBOutlet weak var image: UIImageView!
    
    var date: Date!
    var weight: Float? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightText.delegate = self
        
        setDate()
        downloadAndSetImage()
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
        
        if let w:Float = Float(weightText.text!) ?? 0 {
            self.weight = w
        } else {
            fatalError("Failed to extract weight")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        weightText.resignFirstResponder()
        return true
    }
    
    func getDate(completion: @escaping (String, Error?)->()) {
        self.date = Date()
        do {
            let date = try Utils.dateToStr(date: self.date)
            completion(date, nil)
        } catch let error {
            completion("", error)
        }
    }
    
    func setDate() {
        DispatchQueue.global(qos: .utility).async {
            self.getDate() {
                result, error in
                let res: String? = result
                guard let text = res else {return}
                DispatchQueue.main.async {
                    self.dateLabel.text = text
                }
            }
        }
    }
    
    func downloadAndSetImage() {
        DispatchQueue.global(qos: .utility).async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
            let url = URL(string: "http://kilogramus.ru/wp-content/uploads/2015/03/image61.jpeg")
            let dataTask = defaultSession.dataTask(with: url!)  {
                data, response, error in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let error = error {
                    print(error.localizedDescription)
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        DispatchQueue.main.async {
                            self.image.image = UIImage(data: data!)
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
}
