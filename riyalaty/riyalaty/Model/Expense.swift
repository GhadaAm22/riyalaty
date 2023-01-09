//
//  Expense.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 16/06/1444 AH.
//

import Foundation

// Expense Model

struct Expense: Identifiable{
    var id = UUID().uuidString
    var expenseCategory: String
    var expenseAmount: Float
    var expenseDate: Date
    
}
