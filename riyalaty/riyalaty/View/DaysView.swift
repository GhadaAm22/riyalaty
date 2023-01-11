//
//  DaysView.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 16/06/1444 AH.
//

import SwiftUI

struct DaysView: View {
    @State var showSheetView = false
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
                                    }
                                    // foreground style
                                    .foregroundStyle(expenseModel.isToday(date: day) ? .primary : .tertiary)
                                    .foregroundColor(expenseModel.isToday(date: day) ? .white : .black)
                                    //capsule shape
                                    .frame(width: 45,height: 90)
                                    .background(
                                        ZStack{
                                            // matched geometry effect
                                            if expenseModel.isToday(date: day){
                                                Capsule()
                                                    .fill(.black)
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                    )
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
                    Text("Total Expanse")
                    Text("500 SR")
                }
                .font(.title).bold()
                //testing
                VStack{
                    HStack{
                        Text("Expenditure List :")
                            .padding(.leading)
                        Spacer()
                    }.font(.title2).bold()
                        .foregroundColor(.white)
                        .frame(width: 350, height: 40)
                        .background(Color.black)
                        .cornerRadius(2)
                        .shadow(color:Color.white ,radius: 2 , x: 0.0 , y: 1)
                        .padding(.bottom , 2)
                    ScrollView{
                        LazyVStack(spacing: 20){
                            if let expenses = expenseModel.filterExpenses{
                                if expenses.isEmpty{
                                    Text("No expences done yet!!!")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                        .fontWeight(.light)
                                        .offset(y:100)
                                        .padding(.top,-30)
                                }
                                else{
                                    ForEach(expenses) { expense in
                                        ExpenseCardView(expense: expense)
                                    }
                                }
                            }
                            else{
                                // progress View
                                ProgressView()
                                    .offset(y: 100)
                            }
                        }
                        // updating Expenses ******** there is current month
                        .onChange(of: expenseModel.currentDay){ newValue in
                            expenseModel.filterTodayExpenses()
                        }
                    }
                    .padding(.bottom)
                }
                .frame(width: 350, height: 230)
                .background(Color.black)
                .cornerRadius(20)
                .shadow(color:Color.black.opacity(0.3) ,radius: 20 , x: 0.0 , y: 10)
                .shadow(color:Color.black.opacity(0.2) ,radius: 5 , x: 0.0 , y: 2)
                
                VStack{
                    HStack{
                        Text("Expenses  Chart :")
                            .padding(.leading)
                        Spacer()
                    }.font(.title2).bold()
                        .foregroundColor(.white)
                        .frame(width: 350, height: 40)
                        .background(Color.black)
                        .cornerRadius(2)
                        .shadow(color:Color.white ,radius: 2 , x: 0.0 , y: 1)
                        .padding(.bottom , 2)
                    ScrollView{
                        LazyVStack{
                            
                            PieChartSimple()
                            
                            
                        }}
                }
                .frame(width: 350, height: 230)
                .background(Color.black)
                .cornerRadius(20)
                .shadow(color:Color.black.opacity(0.3) ,radius: 20 , x: 0.0 , y: 10)
                .shadow(color:Color.black.opacity(0.2) ,radius: 5 , x: 0.0 , y: 2)
                .padding(.top)
                NavigationLink {
                    testUIView()
                } label: {
                    Label("View Monthly Report", systemImage: "folder")
                        .frame(width: 200, height: 30)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(20)
                        .shadow(color:Color.black.opacity(0.2) ,radius: 5 , x: 0.0 , y: 2)
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
                        
                    }
                    
                }
        }
        .sheet(isPresented: $showSheetView) {
            AddExpense(showSheetView: $showSheetView)
        }

        }
    }
    // Header
    func ExpenseCardView(expense: Expense)->some View{
        HStack{
            Text(expense.expenseCategory)
            Spacer()
            Text(String(format: "%.2f SR", expense.expenseAmount))
        }
        .padding()
        .font(.title3).bold()
        .foregroundColor(.black)
        .frame(width: 300, height: 30)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color:Color.white.opacity(0.1) ,radius: 2 , x: 0.0 , y: 1)
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
}

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
