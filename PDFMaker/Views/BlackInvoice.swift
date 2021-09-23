//
//  BlackInvoice.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/22/21.
//

import SwiftUI

struct BlackInvoice: View {
    let data = (1...100).map { "Item \($0)" }

    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 50, maximum: 100))
    ]
    let items: [String] = [
        "New Christmas Lights",
        "Fixed Washing Machine",
        "Repaired Fence"
    ]
    var body: some View {
        ScrollView(.vertical){
            HStack(alignment: .top){
                Color.yellow
                    .frame(width: 50, height: 50)
                    .overlay(Text("BK").fontWeight(.heavy).foregroundColor(.darkGrey))
                Spacer()
                VStack(alignment: .leading, spacing: 20){
                    Text("Invoice")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    VStack(alignment: .leading, spacing: 10){
                        Text("Invoice #")
                            .font(.headline)
                        Text("49764128745")
                            .foregroundColor(.gray)
                    }
                    VStack(alignment: .leading, spacing: 10){
                        Text("Date")
                            .font(.headline)
                        Text("05/26/2021")
                            .foregroundColor(.gray)
                    }
                }
                .padding([.leading], 50)
                Spacer()
            }
            .padding([.leading, .top, .bottom], 50)
            .background(Color.iceWhite.opacity(0.4))
            
            HStack(alignment: .center){
                VStack(alignment: .leading, spacing: 10){
                    Text("Bill To:")
                        .font(.headline)
                    Text("Timmy Turner")
                    Text("957 North Street")
                    Text("Los Angeles, California")
                    Text("United States")
                    
                    Spacer(minLength: 20)
                    
                    Text("Phone number")
                        .font(.headline)
                    Text("310.234.9898")
                }
                Spacer()
                VStack(alignment: .leading, spacing: 10){
                    
                    Text("Bill From:")
                        .font(.headline)
                    Text("Bob Knight")
                    Text("3424 South Ave")
                    Text("New York, New York")
                    Text("United States")
                    
                    Spacer(minLength: 20)
                    
                    Text("Phone number")
                        .font(.headline)
                    Text("646.444.7934")

                }
                Spacer()
            }.padding([.leading, .top,.bottom], 50)
            
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 100) {
                    Text("ITEM")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    HStack{
                        Text("COST")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .center)
                            
                        Text("QTY")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .center)
                            
                        Text("PRICE")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .center)
                    }
                }
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                .font(.subheadline.bold())
                .background(Color.iceWhite.opacity(0.4))
                .fixedSize(horizontal: false, vertical: true)
                
                ForEach(self.items, id: \.hash) { (item) in
                    HStack(spacing: 100) {
                        Text(item)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text("6.00")
                                .frame(minWidth: 100, maxHeight: .infinity, alignment: .center)
                            Text("90")
                                .frame(minWidth: 100, maxHeight: .infinity, alignment: .center)
                            Text("$ 540.00")
                                .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                        }
                    }
                    .padding(.horizontal, 50)
                    .fixedSize(horizontal: false, vertical: true) //<---Here
                }
                Divider()
                // MARK: Total
                HStack(spacing: 100) {
                    Spacer()
                    HStack{
                        Text("SUBTOTAL")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .leading)
                        Text("$ 4209.00")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                    }

                }
                .padding(.horizontal, 50)
                .font(.subheadline)
                
                HStack(spacing: 100) {
                    Spacer()
                    HStack{
                        Text("DISCOUNTS")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .leading)

                        Text("-$4109.00")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                    }
                    
                }
                .padding(.horizontal, 50)
                .font(.subheadline)
                
                HStack(spacing: 100) {
                    Spacer()
                    HStack{
                        Text("PAID")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .leading)
                            
                        Text("-$100.00")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                    }
                    
                }
                .padding(.horizontal, 50)
                .font(.subheadline)
                Divider()
                HStack(spacing: 100) {
                    Spacer()
                    HStack{
                        Text("AMOUNT DUE")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .leading)
                            
                        Text("$0.00")
                            .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                    }
                }
                .padding(.horizontal, 50)
                .font(.subheadline.bold())
                
            }
        }
        .foregroundColor(.darkGrey)
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct BlackInvoice_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            BlackInvoice()
                .previewDevice("iPad mini (6th generation)")
                .previewInterfaceOrientation(.portraitUpsideDown)
        } else {
            // Fallback on earlier versions
        }
    }
}
