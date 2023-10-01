//
//  Expense.swift
//  Expense Tracker
//
//  Created by Himanshu Sherkar on 30/09/23.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
}
