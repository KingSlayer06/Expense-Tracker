//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Himanshu Sherkar on 30/09/23.
//

import SwiftUI
import SwiftData

@main
struct Expense_TrackerApp: App {
    
    let container: ModelContainer = {
        let schema = Schema([Expense.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ExpensesView()
        }
        .modelContainer(container)
    }
}
