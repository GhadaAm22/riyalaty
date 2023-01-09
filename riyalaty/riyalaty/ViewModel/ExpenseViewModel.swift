//
//  ExpenseViewModel.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 16/06/1444 AH.
//

import SwiftUI

class ExpenseViewModel: ObservableObject{
    //1673169938
    // Sample expense
    @Published var storedExpense: [Expense] = [
        Expense(expenseCategory: "􀸩 Resturent" ,expenseAmount: 180 ,expenseDate: .init(timeIntervalSince1970: 1673256338)),
        Expense(expenseCategory: "􀙘 Transportion" ,expenseAmount: 290 ,expenseDate: .init(timeIntervalSince1970: 1673256338)),
        Expense(expenseCategory: "􀸘 Coffee" ,expenseAmount: 30 ,expenseDate: .init(timeIntervalSince1970: 1673256338))
    ]
    
    // current week Days
    @Published var curreWeek: [Date] = []

    // current day
    @Published var currentDay: Date = Date()
    
    // intializing
    init(){
        fetchCurrenWeek()
        fetchCurrenMonth()
    }
    func fetchCurrenWeek(){
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day , value: day, to: firstWeekDay){
                curreWeek.append(weekday)
            }
        }
    }
    // Extraction date
    func extractDate(date: Date, format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    // checking if current Date is today
    func isToday(date: Date)->Bool{
        let calender = Calendar.current
        
        return calender.isDate(currentDay, inSameDayAs: date)
    }
    
    
    
    //current Months
    @Published var curreMonths: [Date] = []

    // current day
    @Published var currentMonth: Date = Date()

    // intializing
//    init(){
//        fetchCurrenWeek()
//    }
    func fetchCurrenMonth(){
        let thisMonth = Date()
        let calendar = Calendar.current
        
        let month = calendar.dateInterval(of: .month, for: thisMonth)
        let currentDate = calendar.component(.day)
        var valueToReduce = -1
               if currentDate > 15 {
                   valueToReduce = -2
               }
        guard let firstMonthDay = month?.start else{
            return
        }
        (1...7).forEach{ month in
            if let months = calendar.date(byAdding: .month ,value: valueToReduce, to: self){
                curreMonths.append(months)
            }
        }
    }
    // Extraction date
    func extractMonth(date: Date, format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    // checking if current Date is today
    func isThisMonth(date: Date)->Bool{
        let calender = Calendar.current
        
        return calender.isDate(currentMonth, inSameDayAs: date)
    }
    


}


