//
//  File.swift
//  Массовый дневник Swift
//
//  Created by Admin on 01.10.17.
//  Copyright © 2017 Bonaventura. All rights reserved.
//

import Foundation

class DateError: Error {
    let error: String
    init(error: String) {
        self.error = error
    }
}
