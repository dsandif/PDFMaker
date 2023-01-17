//
//  InvoiceItemView.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/21/21.
//

import SwiftUI
import Combine
import Currency

struct LineItemView: View {
    var item: InvoiceItem
    
    var body: some View{
        HStack(alignment: .center, spacing: 20){
            Text(item.description)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .truncationMode(.tail)
            Text("$\(item.price.localizedString())")
                .fontWeight(.heavy)
                .font(.system(size: 12).lowercaseSmallCaps())
        }
        .font(.system(size: 10).lowercaseSmallCaps())

    }
}

struct LineItemEditor: View{
    @Binding var item: InvoiceItem
    @State var price: String = ""
    @State var qty: String = ""
    var showQty = true
    
    var body: some View{
        Form{
            Section(header: Text("Edit Item")){
                HStack{
                    TextField("description", text: $item.description)
                        .keyboardType(.alphabet)

                    Text("|")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    
                    TextField("cost", text: $price)
                        .keyboardType(.numberPad)
                        .onChange(of: price){inputVal in
                            var test = inputVal.decimalAllowable

                            if(test.count == 1){
                                test = "." + test
                            }else if(test.count > 1){
                                test.insert(".", at: test.index(test.endIndex, offsetBy: -2))
                            }
                            price = test
                        }
                    if showQty {
                        Text("|")
                            .foregroundColor(.gray)
                            .opacity(0.6)
                        TextField("qty", text: $qty)
                            .keyboardType(.numberPad)
                            .onChange(of: qty){inputVal in
                                var test = inputVal.decimalAllowable

                                if(test.count == 1){
                                    test = "." + test
                                }else if(test.count > 1){
                                    test.insert(".", at: test.index(test.endIndex, offsetBy: -2))
                                }
                                qty = test
                            }
                    }
                }
            }
        }
        .onDisappear(perform: {
            if(price != ""){
                item.price = USD(amount: Decimal(Double(price)!))!
            }
            if(qty != ""){
                item.quantity = Double(qty)!
            }
        })
    }
}
extension String {
    var decimalAllowable: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined().lowercased()
    }
}

struct LineItemView_Previews: PreviewProvider {
    static var previews: some View {
        LineItemEditor(item: .constant(InvoiceItem(description: "new item ", price: 200.0)))
    }
}
