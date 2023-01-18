//
//  DaysView.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 16/06/1444 AH.
//

import SwiftUI

public var total : Float = 0

struct DaysView: View {
    //for update cordata
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
    
    
    
    //============
    @StateObject var expenseModel: ExpenseViewModel = ExpenseViewModel()
    @Namespace var animation
    var body: some View {
        NavigationView(){
            
            ScrollView(.vertical, showsIndicators: false){
                // lazy stack with pinned Header
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders] ){
                    Section{
                        
                        // current week view
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 10){
                                ForEach(expenseModel.curreWeek, id: \.self){day in
                                    VStack(spacing: 10){
                                        Text(expenseModel.extractDate(date: day, format: "dd"))
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                        
                                        Text(expenseModel.extractDate(date: day, format: "EEE"))
                                            .font(.system(size: 14))
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 8,height: 8)
                                            .opacity(expenseModel.isToday(date: day) ? 1: 0)
                                    }                                            .accessibilityLabel("Choose a day")
                                    
                                    // foreground style
                                        .foregroundStyle(expenseModel.isToday(date: day) ? .primary : .tertiary)
                                        .foregroundColor(expenseModel.isToday(date: day) ? .black : .black)
                                    //capsule shape
                                        .frame(width: 45,height: 90)
                                        .background(
                                            ZStack{
                                                // matched geometry effect
                                                if expenseModel.isToday(date: day){
                                                    Capsule()
                                                        .fill(.white)
                                                        .shadow(color:Color.black ,radius: 3 , x: 0.0 , y: 1.5)
                                                        
                                                        .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                                }
                                            }
                                        ).padding(.top, 3)
                                        .padding(.bottom, 3)
                                        .contentShape(Capsule())
                                        .onTapGesture {
                                            //updating currentday
                                            withAnimation{
                                                expenseModel.currentDay = day
                                            }
                                        }
                                    
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    //                header: {
                    //                        HeaderView()
                    //                    }
                }
                VStack{
                    Text("Total Expense")
                    Text(String(format: "%.2f SR", total))
                    //SomeView()
                }
                
                .font(.title).bold()
                //testing
                VStack{
                    HStack{
                        Text("Expenditure List:")
                            .padding(.leading)
                        Spacer()
                    }.font(.title2).bold()
                        .foregroundColor(.black)
                        .frame(width: 350, height: 40)
                        .background(Color.white)
                        .cornerRadius(2)
                        .shadow(color:Color.black ,radius: 3 , x: 0.0 , y: 1.5)
                        .padding(.bottom , 2)
                    //working one ============================
                    //                    ZStack(alignment: .bottom){
                    //                    List {
                    //                        //allTasks
                    //                        ForEach(allTasks) { task in
                    //
                    //                        ExpenseCardView(expense: task)
                    //                                .font(.title3).bold()
                    //                                .foregroundColor(.black)
                    //                                .frame(width: 350, height: 30)
                    //                                .background(Color.white)
                    //                                .cornerRadius(5)
                    //                                .shadow(color:Color.white.opacity(0.2) ,radius: 2 , x: 0.0 , y: 1)
                    //
                    //                            //ExpenseCardView(expense: task)
                    //
                    // hena                       }.accessibilityLabel("Swip left to Delete an expense")
                    //                        .onDelete(perform: deleteTask)
                    //
                    //                    }.scrollContentBackground(.hidden)
                    //                    .accessibilityLabel("Expenditure List")
                    //
                    //                    .listStyle(.sidebar)
                    //                        .frame(width: 390, height: 230)
                    //                        .background(Color.white)
                    //                        .padding(.top ,-30)
                    //
                    //                    }
                    //                        .frame(width: 350, height: 180)
                    //                      //  .background(Color.pink)
                    //                        .cornerRadius(2)
                    //
                    //                        .padding(.bottom ,2)
                    
                    //working one ============================
                    
                    
                    //testing one ========================
                    
                    ZStack(alignment: .bottom){
                        List {
                            // Converting object as our Task Model
                            DynamicFilteredView( dateToFilter: expenseModel.currentDay){ (object: Task) in
                                ExpenseCardView(expense: object)
                            }
                            
                                                }
                        
                        .scrollContentBackground(.hidden)
                            .accessibilityLabel("Expenditure List")
                        
                            .listStyle(.sidebar)
                            .frame(width: 390, height: 230)
                            .background(Color.white)
                            .padding(.top ,-30)
                        
                    }
                    .frame(width: 350, height: 180)
                     
                    .cornerRadius(2)
                    
                    .padding(.bottom ,2)
                    
                    // updating Expenses ******** there is current month
             
                
                
                //testing one ========================
            }
            .frame(width: 350, height: 230)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color:Color.black.opacity(0.3) ,radius: 20 , x: 0.0 , y: 10)
            .shadow(color:Color.black.opacity(0.2) ,radius: 5 , x: 0.0 , y: 2)
            
            VStack{
                HStack{
                    Text("Expenses  Chart:")
                        .padding(.leading)
                    Spacer()
                }.font(.title2).bold()
                    .foregroundColor(.black)
                    .frame(width: 350, height: 40)
                    .background(Color.white)
                    .cornerRadius(2)
                    .shadow(color:Color.black ,radius: 3 , x: 0.0 , y: 1.5)
                    .padding(.bottom , 2)
                ScrollView{
                    LazyVStack{
                            PieChartSimple()
                        
                        
                        
                        
                    }}.accessibilityLabel("your expenses chart")
            }
            .frame(width: 350, height: 230)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color:Color.black.opacity(0.3) ,radius: 20 , x: 0.0 , y: 10)
            .shadow(color:Color.black.opacity(0.2) ,radius: 5 , x: 0.0 , y: 2)
            .padding(.top)
            NavigationLink {
                testUIView()
            } label: {
                Label("View Monthly Report", systemImage: "")
                    .frame(width: 180, height: 30)
                    .font(.caption)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color:Color.black.opacity(0.2) ,radius: 8 , x: 0.0 , y: 4)
                    .padding(.trailing, -100)
            }
        
            }
            .navigationTitle("My Expenses")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showSheetView.toggle()
                    }) {
                        Image(systemName: "plus")
                        
                    }.accessibilityLabel("click to add a new expense")
                    
                }
        }
        .sheet(isPresented: $showSheetView) {
            AddExpense(showSheetView: $showSheetView)
        }

        }
    }
}
    // Header
    //was Expense
//
//     func SomeView()->some View{
//
//        VStack{//was felterdexpense
//
//            if let expenses = expenseModel.filterExpenses{
//
//                if expenses.isEmpty{
//                    Text(String(format: "%.2f SR", 0))
//
//                    Text(String(format: "%.2f SR", colculateTotal(expenses: allTasks.sorted(by: { $0.isInserted == $1.isInserted }))))
////                    Text(String(format: "%.2f SR", colculateTotal(expenses: allTasks.first()!.dateCreated)))
//                }
//                else{
//
//                    Text(String(format: "%.2f SR", colculateTotal(expenses: expenses)))
//                }
//            }
//            else{
//                // progress View
//                ProgressView()
//                    .offset(y: 100)
//            }
//        }
//        // updating Expenses ******** there is current month
//
//    }
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
        //            Text("formatter \(expense.dateCreated! , formatter: itemFormatter)")
    }()
func ExpenseCardView(expense: Task)->some View{
    
        //Since CoreData Values will Give Optinal data
        HStack{
            Text(expense.priority ?? "expense.priority")
            
            Spacer()
            //            Text(("\(expense.dateCreated)" ?? "expense.title") + " SR" )
            Text((expense.title ?? "expense.title") + " SR" )
            
            
        }
        .font(.title3).bold()
        .padding()
    }

//    func HeaderView()->some View{
//        HStack(spacing: 0){
//            VStack(alignment: .leading, spacing: 0){
////                Text(Date().formatted(date: .abbreviated, time: .omitted))
////                    .foregroundColor(.gray)
//                Text("Navigation place")
//                    .font(.title2.bold())
//            }
//            .hLeading()
//            .padding(.top,-30)
//            .padding(.bottom, -40)
////            Button{
////
////            } label: {
////                //image 3:39
////            }
//        }
//        .padding()
//        .background(Color.white)
//    }
//}

struct DaysView_Previews: PreviewProvider {
    static var previews: some View {
        DaysView()
    }
}

// UI design Helper function
extension View{
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    func hTrailing()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .trailing)
    }
    func hCenter()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .center)
    }
}



// the expenditure list befor
//VStack{
//    HStack{
//        Text("Expenditure List :")
//            .padding(.leading)
//        Spacer()
//    }.font(.title2).bold()
//        .foregroundColor(.white)
//        .frame(width: 350, height: 40)
//        .background(Color.black)
//        .cornerRadius(2)
//        .shadow(color:Color.white ,radius: 2 , x: 0.0 , y: 1)
//        //.shadow(radius: 10)
////                    .padding(.leading)
////                    .padding(.top)
//        .padding(.bottom , 2)
//    ScrollView{
//        LazyVStack(spacing: 20){
//            ForEach(expenseModel.storedExpense, id: \.self){item in
//                HStack{
//
//                    Text(item.expenseCategory)
//                    Spacer()
//                    Text(String(format: "%.2f SR", item.expenseAmount))
//
//                }
//                    .padding()
//                    .font(.title3).bold()
//                    .foregroundColor(.black)
//                    .frame(width: 300, height: 30)
//                    .background(Color.white)
//                    .cornerRadius(5)
//                    .shadow(color:Color.white.opacity(0.1) ,radius: 2 , x: 0.0 , y: 1)
//            }
//
//        }
//    }
//    .padding(.bottom)
//}
//.frame(width: 350, height: 230)
//.background(Color.black)
//.cornerRadius(20)
//.shadow(color:Color.black.opacity(0.3) ,radius: 20 , x: 0.0 , y: 10)
//.shadow(color:Color.black.opacity(0.2) ,radius: 5 , x: 0.0 , y: 2)
