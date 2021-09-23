//
//  InvoiceItemView.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/21/21.
//

import SwiftUI

struct LineItemView: View {
    var item: InvoiceItem
    
    var body: some View{
        HStack(alignment: .center, spacing: 20){
            Text(item.description)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .truncationMode(.tail)
//            Text("\(item.quantity, specifier: "%.1f") \(item.quantityType)")
//                .fontWeight(.light)
//                .foregroundColor(Color("Blue300"))
//                .background(RoundedRectangle(cornerRadius: 25.0).frame(minWidth: 65, minHeight: 12, alignment: .center)
//                )
            Spacer()
            
            Text("$\(item.price, specifier: "%.2f")")
                .fontWeight(.heavy)
                .font(.system(size: 12).lowercaseSmallCaps())
        }
        .font(.system(size: 10).lowercaseSmallCaps())

    }
}

struct LineItemView_Previews: PreviewProvider {
    static var previews: some View {
        LineItemView(item: InvoiceItem(description: "new item ", price: 200.0))
    }
}
