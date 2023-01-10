//
//  testUIView.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 17/06/1444 AH.
//

import SwiftUI

struct testUIView: View {
    @State var Months = ["Jan", "Feb", "Mar","Apr", "May", "Jun","Jul","Aug","Sep" ,"Oct","Nov","Dec"]
    var body: some View {
        HStack(spacing: 10){
            ForEach(Months, id: \.self){month in
                HStack{
                    Text(month)
                }
            }
        }
    }
}
    struct testUIView_Previews: PreviewProvider {
        static var previews: some View {
            testUIView()
        }
    }

