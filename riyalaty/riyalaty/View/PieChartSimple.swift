//
//  PieChartSimple.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 18/06/1444 AH.
//

import SwiftUI

struct PieChartSimple : View {
        @ObservedObject var charDataObj = ChartDataContainer()
        @State var indexOfTappedSlice = -1
        var body: some View {
            HStack {
                //MARK:- Pie Slices
                ZStack {
                    ForEach(0..<charDataObj.chartData.count) { index in
                        Circle()
                            .trim(from: index == 0 ? 0.0 : charDataObj.chartData[index-1].value/100,
                                  to: charDataObj.chartData[index].value/100)
                            .stroke(charDataObj.chartData[index].color,lineWidth: 30)
                            .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                            .animation(.spring())
                    }
                }.frame(width: 80, height: 80)
                    .padding(30)
                    .onAppear() {
                        self.charDataObj.calc()
                    }
                VStack{
                ForEach(0..<charDataObj.chartData.count) { index in
                    HStack {
                        Text(String(format: "%.2f", Double(charDataObj.chartData[index].percent))+"%").minimumScaleFactor(0.8).lineLimit(1)
                            .foregroundColor(.black)
                            .onTapGesture {
                                indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                            }
                            .font(indexOfTappedSlice == index ? .headline : .subheadline)
                        RoundedRectangle(cornerRadius: 3)
                            .fill(charDataObj.chartData[index].color)
                            .frame(width: 10, height: 10)
                    }
                }
            }
                  .padding(3)
                  .frame(width: 80, alignment: .trailing)
            }
        }
    }
struct PieChartSimple_Previews: PreviewProvider {
    static var previews: some View {
        PieChartSimple()
    }
}
