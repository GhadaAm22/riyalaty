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
        }
    }
    // Header
    func HeaderView()->some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
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
