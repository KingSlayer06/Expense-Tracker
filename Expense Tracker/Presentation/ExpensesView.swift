//
//  ContentView.swift
//  Expense Tracker
//
//  Created by Himanshu Sherkar on 30/09/23.
//

import SwiftUI
import SwiftData

// MARK: - ExpenseView
struct ExpensesView: View {
    
    @Environment(\.modelContext) var context
    @Query(sort: \Expense.date) var expenses: [Expense]
    @State var isShowingExpenseSheet: Bool = false
    @State private var expenseToEdit: Expense?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expenseToEdit = expense
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                    }
                }
            }
            .navigationTitle("Expenses")
            .sheet(isPresented: $isShowingExpenseSheet) {
                AddExpenseSheet()
            }
            .sheet(item: $expenseToEdit) { expense in
                UpdateExpenseSheet(expense: expense)
            }
            .toolbar {
                if !expenses.isEmpty {
                    Button("Add Expense", systemImage: "plus") {
                        isShowingExpenseSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding expenses to your list.")
                    }, actions: {
                        Button("Add Expense") {
                            isShowingExpenseSheet = true
                        }
                    })
                    .offset(y: -40)
                }
            }
        }
    }
}

// MARK: - Expense Cell View
struct ExpenseCell: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70, alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
        }
    }
}

// MARK: - ExpenseView Preview
#Preview {
    ExpensesView()
}
