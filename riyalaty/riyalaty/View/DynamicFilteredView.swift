//
//  DynamicFilteredView.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 21/06/1444 AH.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View,T>: View where T:NSManagedObject {
    @StateObject var expenseModel: ExpenseViewModel = ExpenseViewModel()
    // MARK: Core Data Request
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    // Building Custom ForEach which will give Coredata object to build View
   
    init(dateToFilter: Date,@ViewBuilder content: @escaping (T)->Content){
        // Predicaye to Filter current date Tasks
        let calender = Calendar.current
        
        let today = calender.startOfDay(for: dateToFilter)
        let tommorow = calender.date(byAdding: .day,value: 1, to: dateToFilter)!
        // Filter Key
        let filterKey = "dateCreated"
        // This will fetch task between today and Tommorow which is 24 HRS
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today,tommorow])
        //intializing Request with NSPredicate
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.dateCreated, ascending: false)], predicate: predicate)
        total = 0
        self.content = content
      
    }
    private func deleteTask(at offsets: IndexSet){
        offsets.forEach { index in
            let task = request[index]
            viewContext.delete(task)

            do {
                try viewContext.save()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        Group{
            if request.isEmpty{
                Text("No expences done yet!!!")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y:100)
                    .padding(.top,-30)
            }
            else{
                ForEach(request,id: \.objectID){object in
                    self.content(object)
                    
                }.accessibilityLabel("Swip left to Delete an expense")
                    .onDelete(perform: deleteTask)
                    
                    
            }
        }
    }
}

