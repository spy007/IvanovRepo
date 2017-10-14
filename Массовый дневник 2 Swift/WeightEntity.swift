//
//  Weight.swift
//  Массовый дневник 2 Swift
//
//  Created by Admin on 10.10.17.
//  Copyright © 2017 Bonaventura. All rights reserved.
//

import Foundation

struct WeightEntity {
    var date: Date? = nil
    var kg: Float? = nil
    
    init() {}
    
    init(date: Date, kg: Float) {
        self.date = date
        self.kg = kg
    }
}
