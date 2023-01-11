//
//  AddExpense.swift
//  ToDoList
//
//  Created by Ghada Amer Alshahrani on 18/06/1444 AH.
//

import SwiftUI
enum Priority: String , Identifiable, CaseIterable{
    var id:UUID {
        return UUID()
    }
    case Transportation = "Transportation"
    case Entertainment = "Entertainment"
    case HealthCare = "Health & Care"
    case Groceries = "Groceries"
    case Shopping = "Shopping"
    case Coffee = "Coffee"
    case Home = "Home"
    case Bill = "Bill"
    case Other = "Other"
    
}
extension Priority {
    var title: String {
        switch self {
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
    
}

struct AddExpense: View {
    let backGroundColor = Color("BGColor")
    @Binding var showSheetView: Bool
    @State private var title: String = ""
    @State private var selectedPriority: Priority = .Transportation
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)])
    private var allTasks: FetchedResults<Task>
    
    private func saveTask() {
        do {
            let task = Task(context: viewContext)
            task.title = title
            task.priority = selectedPriority.rawValue
            task.dateCreated = Date()
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
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
    
    
    

        var body: some View {
            NavigationView{
                VStack {
                    Text("Categories")
                        .font(.headline)
                        .padding(.trailing, 265)
                    ZStack() {
                        RoundedRectangle(cornerRadius: 9)
                            .fill(Color("LBlue"))
                            .frame(width: 361, height: 235)
                    Picker("Categories", selection: $selectedPriority){
                        ForEach(Priority.allCases){Priority in
                            Text(Priority.title).tag(Priority)
                        }
                        }
                    }.pickerStyle(.wheel)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .background(Color("LBlue"))
//                        .clipShape(RoundedRectangle(cornerRadius: 17))
                    
                    
                    ZStack() {
                        RoundedRectangle(cornerRadius: 9)
                            .fill(Color("LBlue"))
                            .frame(width: 361, height: 72)
                        HStack{
                            Text("Price")
                                .padding(.leading, 25)
                            TextField("50 SR", text: $title)
                                .padding(.leading, 60)
                                .background(RoundedRectangle(cornerRadius: 4).fill(backGroundColor))
                                .padding(.leading, 80)
                                .accentColor(Color("DBlue"))
                                .padding()
                                .keyboardType(.phonePad)
                            
                        }}
                    
                    
                    Button("Add"){
                        saveTask()
                        
                    }
                    .frame(width: 361, height: 40)
                    .background(Color("DBlue"))
                    .cornerRadius(9)
                    .foregroundColor(Color("whitee"))
                    .padding(.vertical, 8)
                    
                    
//                    List {
//                        ForEach(allTasks){ task in
//                            HStack{
//                                Text(SysImage(task.priority!))
//                                Text(styleForPriority(task.priority!))
//                                Spacer()
//
//                                Text(task.title ?? "")
//                            }
//                        }.onDelete(perform: deleteTask)
//
//                    }.listStyle(.sidebar)
//                        .foregroundColor(Color("DBlue"))
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Add Expenses")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Done") {
                            showSheetView=false
                            
                        }
                    }
                    
                }
            }
        }
    }

//struct AddExpense_Previews: PreviewProvider {
//    static var previews: some View {
//        let persistentContainer = CoreDataManeger.shared.persistentContainer
//        AddExpense(showSheetView:$showSheetView).environment(\.managedObjectContext, persistentContainer.viewContext)
//    }
//}
