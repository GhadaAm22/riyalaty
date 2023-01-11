//
//  PieChart.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 18/06/1444 AH.
//

import SwiftUI

struct PieChart : View {
    @ObservedObject var charDataObj = ChartDataContainer()
    @State var indexOfTappedSlice = -1
    var body: some View {
        VStack {
            //MARK:- Pie Slices
            
            ZStack {
                ForEach(0..<charDataObj.chartData.count) { index in
                    Circle()
                        .trim(from: index == 0 ? 0.0 : charDataObj.chartData[index-1].value/100,
                              to: charDataObj.chartData[index].value/100)
                        .stroke(charDataObj.chartData[index].color,lineWidth: 100)
                        .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                        .animation(.spring())
                }
            }.frame(width: 100, height: 200)
            
            ForEach(0..<charDataObj.chartData.count) { index in
                 HStack {
                     Text(String(format: "%.2f", Double(charDataObj.chartData[index].percent))+"%")
                         .onTapGesture {
                             indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                         }
                         .font(indexOfTappedSlice == index ? .headline : .subheadline)
                     RoundedRectangle(cornerRadius: 3)
                         .fill(charDataObj.chartData[index].color)
                         .frame(width: 15, height: 15)
                 }
             }
             .padding(8)
             .frame(width: 300, alignment: .trailing)
            
            .onAppear() {
                self.charDataObj.calc()
            }
        }
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart()
    }
}
