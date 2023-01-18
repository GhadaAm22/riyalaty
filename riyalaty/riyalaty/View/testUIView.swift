//
//  testUIView.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 17/06/1444 AH.
//

import SwiftUI

struct testUIView: View {
    @State var Months = ["Jan", "Feb", "Mar","Apr", "May", "Jun","Jul","Aug","Sep" ,"Oct","Nov","Dec"]
    @State var thisMonth = "Jan"
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)])
    private var allTasks2: FetchedResults<Task>
    
    @StateObject var expenseModel: ExpenseViewModel = ExpenseViewModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            // lazy stack with pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders] ){
                Section{
                    // current week view
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(Months, id: \.self){month in
                                VStack(spacing: 10){
                                    
                                    
                                    Text(month)
                                        .font(.system(size: 14))
                                        .onTapGesture {
                                            thisMonth = month
                                        }
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8,height: 8)
                                        .opacity(month == thisMonth ? 1: 0)
                                }
                                // foreground style
                                .foregroundStyle(month == thisMonth ? .primary : .tertiary)
                                .foregroundColor(month == thisMonth ? .black : .black)
                                //capsule shape
                                .frame(width: 45,height: 90)
                                .background(
                                        ZStack{
                            //     matched geometry effect
                            if (month == thisMonth){
                                Capsule()
                                    .fill(.white)
                                    .shadow(color:Color.black ,radius: 3 , x: 0.0 , y: 1.5)
                                                    }
                                    else{
                                        Capsule()
                                            .fill(.white)
                                            
                                
                                        }
                                   }
                                    )
                                .padding(.top, 3)
                                .padding(.bottom, 3)
                                .contentShape(Capsule())
                                //                                .onTapGesture {
                                //                                    //updating currentday
                                //                                    withAnimation{
                                //                                        month == thisMonth
                                //                                    }
                                //                                }
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                } header: {
                    //  HeaderView()
                }
            }
            VStack{
                Text("Total Expanse")
                if (thisMonth == "Jan") {
                    TotalView(allTasks : allTasks2.sorted(by: { $0.isInserted == $1.isInserted }))
                }else{
                    Text(String(format: "%.2f SR", 0))
                }
            }
            .font(.title).bold()
            VStack{
                HStack{
                    Text("Expenses  Chart :")
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
                        if (thisMonth == "Jan") {
                            PieChartSimple()
                        }
                        
                    }}
            }
            .frame(width: 350, height: 230)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color:Color.black.opacity(0.3) ,radius: 20 , x: 0.0 , y: 10)
            .shadow(color:Color.black.opacity(0.2) ,radius: 5 , x: 0.0 , y: 2)
            .padding(.top)
            //        HStack(spacing: 10){
            //            ForEach(Months, id: \.self){month in
            //                HStack{
            //                    Text(month)
            //                }
            //            }
            //        }
        }
    }
    
    func View()->some View{
        Capsule()
            .fill(.white)
            .shadow(color:Color.black ,radius: 3 , x: 0.0 , y: 1.5)
    }
    func ShadowView()->some View{
        Capsule()
            .fill(.white)
            .shadow(color:Color.black ,radius: 3 , x: 0.0 , y: 1.5)
    }
    func HeaderView()->some View{
        HStack(spacing: 0){
            VStack(alignment: .leading, spacing: 0){
                //                Text(Date().formatted(date: .abbreviated, time: .omitted))
                //                    .foregroundColor(.gray)
                Text("Navigation place")
                    .font(.title2.bold())
            }
            .hLeading()
            .padding(.top,-30)
            .padding(.bottom, -40)
            //            Button{
            //
            //            } label: {
            //                //image 3:39
            //            }
        }
        .padding()
        .background(Color.white)
    }
    func colculateTotal(expenses: [Task])->Float{
        var total : Float = 0
        
        for expense in expenses {
            print(expense.title ?? "expense.title")
            total += Float(expense.title ?? "0") ?? 17.00
            print("Total  \(total)")
        }
        print("expenses  \(expenses)")
        print("Total  \(total)")
        return total
    }
    func TotalView(allTasks : [Task])->some View{
        // @Binding var allTasks : Task
        VStack{//was felterdexpense
            
            if let expenses = allTasks{
                
                if expenses.isEmpty{
                    Text(String(format: "%.2f SR", 0))
                    
                    
                    //                    Text(String(format: "%.2f SR", colculateTotal(expenses: allTasks.first()!.dateCreated)))
                }
                else{
                    
                    Text(String(format: "%.2f SR", colculateTotal(expenses: expenses)))
                }
            }
            else{
                // progress View
                ProgressView()
                    .offset(y: 100)
            }
        }
    }
}
    struct testUIView_Previews: PreviewProvider {
        static var previews: some View {
            testUIView()
        }
    }

