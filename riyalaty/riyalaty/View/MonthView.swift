//
//  MonthView.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 16/06/1444 AH.
//

import SwiftUI

struct MonthView: View {
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
                            ForEach(expenseModel.curreMonths, id: \.self){month in
                                VStack(spacing: 10){
                                    Text(expenseModel.extractMonth(date: month, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                    Text(expenseModel.extractMonth(date: month, format: "EEE"))
                                        .font(.system(size: 14))
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8,height: 8)
                                        .opacity(expenseModel.isThisMonth(date: month) ? 1: 0)
                                }
                                // foreground style
                                .foregroundStyle(expenseModel.isThisMonth(date: month) ? .primary : .tertiary)
                                .foregroundColor(expenseModel.isThisMonth(date: month) ? .white : .black)
                                //capsule shape
                                .frame(width: 45,height: 90)
                                .background(
                                    ZStack{
                                        // matched geometry effect
                                        if expenseModel.isThisMonth(date: month){
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
                                        expenseModel.currentMonth = month
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

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView()
    }
}
