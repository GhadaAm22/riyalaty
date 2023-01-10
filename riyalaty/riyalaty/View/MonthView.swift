////
////  MonthView.swift
////  riyalaty
////
////  Created by Sara Khalid BIN kuddah on 16/06/1444 AH.
////
//
//import SwiftUI
//
//struct MonthView: View {
//    //@StateObject var expenseModel: ExpenseViewModel = ExpenseViewModel()
//    let Months = [["Jan",01], ["Feb",02], ["Mar",03], ["Apr",04] , ["May",05], ["Jun",06], ["Jul",07],["Aug",08], ["Sep",09] ,["Oct",10],["Nov",11],["Dec",12]]
//    
//    //@Namespace var animation
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false){
//            // lazy stack with pinned Header
//            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders] ){
//                Section{
//                    // current week view
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack(spacing: 10){
//                            ForEach(Months.indices, id: \.self){index in
//                                VStack(spacing: 10){
//                                    Text(Months[index][1])
//                                        .font(.system(size: 15))
//                                        .fontWeight(.semibold)
//                                    
//                                    Text(Months[0][index])
//                                        .font(.system(size: 14))
////                                    Circle()
////                                        .fill(.white)
////                                        .frame(width: 8,height: 8)
////                                        .opacity(Months[0][index] == "Jan" ? 1: 0)
//                                }
//                                // foreground style
//                                .foregroundStyle(Months[0][index] == "Jan" ? .primary : .tertiary)
//                                .foregroundColor(Months[0][index] == "Jan" ? .white : .black)
//                                //capsule shape
//                                .frame(width: 45,height: 90)
//                                .background(
////                                    ZStack{
////                                        // matched geometry effect
////                                        if Months[0][index] == "Jan"{
////                                            Capsule()
////                                                .fill(.black)
////                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
////                                        }
////                                    }
////                                )
////                                .contentShape(Capsule())
////                                .onTapGesture {
////                                    //updating currentday
////                                    //                                    withAnimation{
////                                    //                                      //  expenseModel.currentMonth = month
////                                    //                                    }
////                                }
////
////                            }
////                        }
////                        .padding(.horizontal)
////                    }
//                }
//                                    }
//                                    //header: {
////                    // HeaderView()
////                }
//            }
//        }
//    }
//    // Header
//    //    func HeaderView()->some View{
//    //        HStack(spacing: 10){
//    //            VStack(alignment: .leading, spacing: 10){
//    //                Text(Date().formatted(date: .abbreviated, time: .omitted))
//    //                    .foregroundColor(.gray)
//    //                Text("Today")
//    //                    .font(.largeTitle.bold())
//    //            }
//    //            .hLeading()
//    ////            Button{
//    ////
//    ////            } label: {
//    ////                //image 3:39
//    ////            }
//    //        }
//    //        .padding()
//    //        .background(Color.white)
//    //    }
//    //
//    //}
//}
//    struct MonthView_Previews: PreviewProvider {
//        static var previews: some View {
//            MonthView()
//        }
//    }
//    }
