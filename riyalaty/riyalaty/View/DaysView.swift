//
//  DaysView.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 16/06/1444 AH.
//

import SwiftUI

struct DaysView: View {
    @StateObject var expenseModel: ExpenseViewModel = ExpenseViewModel()
    @Namespace var animation
    var body: some View {
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
                } header: {
                    HeaderView()
                }
            }
            VStack{
                Text("Total Expanse")
                Text("500 SR")
            }
            .font(.title).bold()
            VStack{
                HStack{
                    Text("Expenditure List :")
                    Spacer()
                }.font(.title2).bold()
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .padding(.leading)
                    .padding(.top)
                    .padding(.bottom , 5)
                ScrollView{
                    VStack(spacing: 20){
                        ForEach(expenseModel.storedExpense, id: \.self){item in
                            HStack{
                                //storedExpense
                                Spacer()
                                Text(item.expenseCategory)
                                Spacer()
                                Text(String(format: "%.2f SR", item.expenseAmount))
                                Spacer()
                            }.font(.title3).bold()
                                .foregroundColor(.black)
                                .frame(width: 280, height: 30)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color:Color.white.opacity(0.2) ,radius: 5 , x: 0.0 , y: 2)
                        }
                        
                    }
                }
            }
            .frame(width: 350, height: 230)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color:Color.black.opacity(0.3) ,radius: 20 , x: 0.0 , y: 10)
            .shadow(color:Color.black.opacity(0.2) ,radius: 5 , x: 0.0 , y: 2)
            VStack{
                HStack{
                    Text("Expenses  Chart :")
                }.font(.title2).bold()
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .padding(.leading)
                    .padding(.top)
                    .padding(.bottom , 10)
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
    }
    // Header
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
