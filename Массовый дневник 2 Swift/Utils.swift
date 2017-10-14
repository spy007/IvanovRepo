//
//  Utils.swift
//  Массовый дневник 2 Swift
//
//  Created by Admin on 03.10.17.
//  Copyright © 2017 Bonaventura. All rights reserved.
//

import Foundation

class Utils {
    class func dateToStr(date: Date) throws -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMMM, yyyy"
                
        let result = formatter.string(from: date)
        if result == "" { throw DateError(error: "failed to get date") }
        return result;
    }
}
