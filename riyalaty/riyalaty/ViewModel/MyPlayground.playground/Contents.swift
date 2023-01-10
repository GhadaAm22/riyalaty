import UIKit
import SwiftUI

var greeting = "Hello, playground"
print(greeting)

//let date = Date()
//let calendar = Calendar.current
//let components = calendar.dateComponents([.month], from: date)
//let month = components.month
//var i : Int = month ?? <#default value#>
//print(i)
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
let date = Date(timeIntervalSince1970:1670657155)
let thismoth = date.get(.month)
var curreMonths: [Date] = []
let calendar = Calendar.current
let mo = calendar.dateInterval(of: .month, for: date)
let firstMonthDay = mo?.start
let dateFormatter = DateFormatter()
        (1...12).forEach{ month in
            if let months = calendar.date(byAdding: .month ,value: month, to: firstMonthDay!
            ){
               // month(date: month, format: "MMM"))
                dateFormatter.dateFormat = "yyyy/MMM"
                dateFormatter.string(from: months)
               curreMonths.append(months)
                
//                curreMonths.append(months(date: month, format: "MMM"))
            }
        }
//date(date: date, format: "EEE"))
dateFormatter.dateFormat = "yyyy/mmm"
dateFormatter.string(from: date)
curreMonths
//let dateFormatter = DateFormatter()
//dateFormatter.string(for: "LLLL")
//let monthString = dateFormatter.string(from: date)
let formatted = Date().formatted(date: .abbreviated, time: .shortened)
let string = Date()
let expectedFormat = Date.FormatStyle()
    .month().year().day()
    .hour().minute()
//let date = try? Date(string, strategy: expectedFormat)

