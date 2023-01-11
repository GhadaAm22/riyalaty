//
//  ContentView.swift
//  ToDoList
//
//  Created by Ghada Amer Alshahrani on 17/06/1444 AH.
//

import SwiftUI

struct FirstPge: View {
    @State var showSheetView = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)])
    private var allTasks: FetchedResults<Task>
    private func SysImage(_ value: String) -> Image{
        let priority = Priority(rawValue: value)
        
        switch priority {
        case .Transportation:
            return Image(systemName: "car")
        case .Home:
            return Image(systemName: "house")
        case .Bill:
            return Image(systemName: "list.bullet.rectangle.portrait")
        case .Entertainment:
            return Image(systemName: "gamecontroller")
        case .HealthCare:
            return Image(systemName: "cross.circle")
        case .Groceries:
            return Image(systemName: "cart")
        case .Shopping:
            return Image(systemName: "bag")
        case .Coffee:
            return Image(systemName: "cup.and.saucer")
        default:
            return Image(systemName: "plus")
        }
    }
    private func styleForPriority(_ value: String) -> String{
        let priority = Priority(rawValue: value)
        
        switch priority {
        case .Transportation:
            return "Transportation"
        case .Entertainment:
            return "Entertainment"
        case .HealthCare:
            return "Health & Care"
        case .Groceries:
            return "Groceries"
        case .Shopping:
            return "Shopping"
        case .Coffee:
            return "Coffee"
        case .Home:
            return "Home"
        case .Bill:
            return "Bill"
        default:
            return "Other"
        }
    }
    private func deleteTask(at offsets: IndexSet){
        offsets.forEach { index in
            let task = allTasks[index]
            viewContext.delete(task)
            
            do {
                try viewContext.save()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    @State private var title: String = ""
    @State private var selectedPriority: Priority = .Transportation
    var body: some View {
        NavigationStack()
        {
            List {
                ForEach(allTasks){ task in
                    HStack{
                        Text(SysImage(task.priority!))
                        Text(styleForPriority(task.priority!))
                        Spacer()
                        
                        Text(task.title ?? "")
                    }
                }.onDelete(perform: deleteTask)
                
            }.listStyle(.sidebar)
                .foregroundColor(Color("DBlue"))
                .navigationTitle("My Expenses")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            showSheetView.toggle()
                        }) {
                            Image(systemName: "plus")
                            
                        }
                        
                    }
                }
        }
        
        .sheet(isPresented: $showSheetView) {
            AddExpense(showSheetView: $showSheetView)
        }
        
        
    }
    
}



struct FirstPge_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer = CoreDataManeger.shared.persistentContainer
        FirstPge().environment(\.managedObjectContext, persistentContainer.viewContext)
        
        
    }
}
