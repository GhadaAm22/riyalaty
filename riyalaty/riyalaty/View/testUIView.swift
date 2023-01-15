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
//                                    Text(expenseModel.extractDate(date: day, format: "dd"))
//                                        .font(.system(size: 15))
//                                        .fontWeight(.semibold)
                                    
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
                                .foregroundColor(month == thisMonth ? .white : .black)
                                //capsule shape
                                .frame(width: 45,height: 90)
                                .background(month == thisMonth ? Capsule().fill(.black) : Capsule().fill(.white))
                            //        ZStack{
                                        // matched geometry effect
//                                   if (month == "Jan"){
//                                            Capsule()
//                                                .fill(.black)
//                                     }
//                                        else{
//                                            Capsule()
//
//                                        }
                                 //   }
     //                           )
                                .contentShape(Capsule())
//                                .onTapGesture {
//                                    //updating currentday
//                                    withAnimation{
//                                        month == "Jan"
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
                Text("500 SR")
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
    struct testUIView_Previews: PreviewProvider {
        static var previews: some View {
            testUIView()
        }
    }

