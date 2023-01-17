//
//  CreateInvoice.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/21/21.
//

import SwiftUI
import Currency

struct InvoiceItem: Identifiable, Hashable {
    let id: UUID = UUID()
    var description: String = ""
    var price: USD = USD(0.00)
    var quantity: Double = 0.0
}

struct CreateInvoice: View {
    @Environment(\.presentationMode) var presentationMode
    @State var lineItems: [InvoiceItem] = []
    @State var showInvoice: Bool = false
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                LabelTextField(label: "To", placeHolder: "Fill in the payer name")
                LabelTextField(label: "Email", placeHolder: "Fill in the payer email")
                LabelTextField(label: "Type", placeHolder: "Fill in the invoice type")
                LabelTextField(label: "Invoice #", placeHolder: "Fill in the invoice number")
                LabelTextField(label: "Your Phone", placeHolder: "Fill  in your phone #")
                VStack{
                    HStack{
                        Text("Line Items")
                        Spacer()
                        Button(action: {
                            let newItem = InvoiceItem(description: "new item", price: USD(floatLiteral: Double.random(in: 0...100.0)))
                            self.lineItems.append(newItem)
                        }, label: {
                            Text("Add")
                        })
                    }
                    ForEach(lineItems, id: \.id){item in
                        Spacer()
                        HStack{
                            Text(item.description)
                            Spacer()
                            Text(item.price.localizedString())
                        }
                    }
                }
                .padding([.horizontal], 15)
                
                RoundedButton().padding(.top, 20)
            }
            .padding(.bottom, 20)
            .listRowInsets(EdgeInsets())
        }
        .sheet(isPresented: $showInvoice){
//            InvoiceView()
//            NavigationView{
//                BlackInvoice(invoiceModel: .constant(InvoiceModel()))
//            }.navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Text("New Invoice"), trailing:
            HStack(spacing: 25){
                Button(action: {
                    
                }, label: {
                    Text("Send")
                })
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
        )
    }

}

struct RoundedButton : View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Spacer()
                Text("Preview Invoice")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.skyBlue)
                Spacer()
            }
        }
        
//        .padding(.vertical, 10.0)
//        .background(Color.skyBlue.cornerRadius(4.0))
//        .padding(.horizontal, 50)
    }
}
struct LabelTextField : View {
    var label: String
    var placeHolder: String
 
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField(placeHolder, text: .constant(""))
                .padding(.all)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0).cornerRadius(5.0))
        }
        .padding(.horizontal, 15)
    }
}
struct CreateInvoice_Previews: PreviewProvider {
    static var previews: some View {
        CreateInvoice()
    }
}