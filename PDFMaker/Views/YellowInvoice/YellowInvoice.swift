//
//  BlackInvoice.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/22/21.
//

import SwiftUI
import Currency
import MessageUI

struct YellowInvoice: View {
    @Environment(\.presentationMode) var presentationMode
    var invoiceModel: InvoiceModel
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 50, maximum: 100))
    ]
    var btnBack: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .font(.body.bold())
                    .foregroundColor(.blue)
                    Text("Back")
            }
        }
    }
    var btnExport: some View {
        Button(action: {
            invoiceModel.exportToPDF(from: body)
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "doc.text.fill")
                    .aspectRatio(contentMode: .fit)
                    .font(.body.bold())
                    
                    Text("Export")
            }
        }
        .buttonStyle(.plain)
        .foregroundColor(.teal)
    }
    
    var btnSend: some View {
        Button(action: {
            invoiceModel.exportToPDF(from: body)
            invoiceModel.emailPDF()
        }) {
            HStack {
                Image(systemName: "paperplane.fill")
                    .aspectRatio(contentMode: .fit)
                    .font(.body.bold())
                    Text("Email")
            }
        }
        .buttonStyle(.plain)
        .foregroundColor(.teal)
    }
    
    var body: some View {
        ScrollView(.vertical){
            invoiceHeader
                .padding(.top, 100)
                .padding([.leading, .bottom], 50)
                .background(Color.iceWhite.opacity(0.4))
            invoiceParties
                .padding([.leading, .top,.bottom], 50)
            lineItemtable
                .onTapGesture(perform: {
                    invoiceModel.showLineItems()
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
        .preferredColorScheme(.light)
        .foregroundColor(.darkGrey)
        .edgesIgnoringSafeArea(.vertical)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack, trailing: HStack{
            btnExport
//            btnSend
        })
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: .constant(invoiceModel.sendEmail), content: {
            MailView(subject: "New Invoice", recipients: [], content: "You have a new invoice from \(invoiceModel.fromFirstname)", attachments: [invoiceModel.exportURL])
        })
    }
    
    @ViewBuilder
    var invoiceHeader: some View {
        HStack(alignment: .top){
            Color.yellow
                .frame(width: 50, height: 50)
                .overlay(
                    Text("DS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.tungsten)
                )
            Spacer()
            VStack(alignment: .leading, spacing: 20){
                Text("Invoice")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                VStack(alignment: .leading, spacing: 10){
                    Text("Invoice #")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(invoiceModel.invoiceNumber)
                        .foregroundColor(.gray)
                }
                VStack(alignment: .leading, spacing: 10){
                    Text("Date")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(invoiceModel.invoiceDate)
                        .foregroundColor(.gray)
                }
            }
            .onTapGesture{
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding([.leading], 70)
            Spacer()
        }
    }
    
    @ViewBuilder
    var invoiceParties: some View{
        HStack(alignment: .center){
            VStack(alignment: .leading, spacing: 10){
                Text("Bill To:")
                    .fontWeight(.semibold)
                Text("\(invoiceModel.toFirstname) \(invoiceModel.toLastname)")
                Text(invoiceModel.toAddress)
                    .lineLimit(2)
                    .truncationMode(.tail)
                if invoiceModel.toCity.count > 0{
                    HStack{
                        Text("\(invoiceModel.toCity), \(invoiceModel.toState) \(invoiceModel.toZip)")
                    }
                    .lineLimit(2)
                }
                
                Text("\(invoiceModel.toCountry)")
                Spacer(minLength: 20)
                Text("Phone number")
                    .fontWeight(.semibold)
                Text(invoiceModel.toPhone)
            }
            .font(.footnote)
            .onTapGesture(perform: {
                invoiceModel.showBillTo()
                self.presentationMode.wrappedValue.dismiss()
            })
            Spacer()
            VStack(alignment: .leading, spacing: 10){
                Text("Bill From:")
                    .fontWeight(.semibold)
                Text("\(invoiceModel.fromFirstname) \(invoiceModel.fromLastname)")
                Text(invoiceModel.fromAddress)
                
                if invoiceModel.toCity.count > 0{
                    HStack{
                        Text("\(invoiceModel.fromCity), \(invoiceModel.fromState) \(invoiceModel.fromZip)")
                    }
                    .lineLimit(2)
                }
                
                Text("\(invoiceModel.fromCountry)")
                Spacer(minLength: 20)
                Text("Phone number")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Text("\(invoiceModel.fromPhone)")

            }
            .font(.footnote)
            .onTapGesture(perform: {
                invoiceModel.showBillFrom()
                self.presentationMode.wrappedValue.dismiss()
            })
            Spacer()
        }
    }
    @ViewBuilder
    var itemTableHeader: some View{
        HStack{
            Text("ITEM")
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                Text("COST")
                    .frame(minWidth: 50, maxHeight: .infinity, alignment: .center)
                    
                Text("QTY")
                    .frame(minWidth: 50, maxHeight: .infinity, alignment: .center)
                    
                Text("TOTAL")
                    .frame(minWidth: 80, maxHeight: .infinity, alignment: .trailing)
            }
        }
    }
    @ViewBuilder
    var itemList: some View {
        ForEach(invoiceModel.lineItems, id: \.id) { item in
            HStack{
                Text(item.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Text(item.price.localizedString())
                        .frame(minWidth: 50, maxHeight: .infinity, alignment: .center)
                    Text(String(item.quantity))
                        .frame(minWidth: 50, maxHeight: .infinity, alignment: .center)
                    Text(item.getAmountForItem().localizedString())
                        .frame(minWidth: 80, maxHeight: .infinity, alignment: .trailing)
                }
            }
            .font(.caption2)
            .padding(.horizontal, 50)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    @ViewBuilder
    var lineItemtable: some View {
        VStack(alignment: .leading, spacing: 20) {
            itemTableHeader
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                .font(.caption2.bold())
                .background(Color.iceWhite.opacity(0.4))
                .fixedSize(horizontal: false, vertical: true)
            itemList
            Divider()
            // MARK: Total
            HStack(spacing: 100) {
                Spacer()
                HStack{
                    Text("SUBTOTAL")
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .leading)
                    Text(invoiceModel.getTotal.localizedString())
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                }

            }
            .padding(.horizontal, 50)
            .font(.caption)
            
            HStack(spacing: 100) {
                Spacer()
                HStack{
                    Text("DISCOUNTS")
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .leading)

                    Text(invoiceModel.discountAmount.localizedString())
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 50)
            .font(.caption)
            Divider()
            HStack() {
                Spacer()
                HStack{
                    Text("AMOUNT DUE")
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .leading)
                    Text(invoiceModel.getAmountDue.localizedString())
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                }
            }
            .padding([.horizontal,.bottom], 50)
            .font(.callout.bold())
        }
    }
}

struct YellowInvoice_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            GeometryReader{geo in
                YellowInvoice(invoiceModel: InvoiceModel())
                    .previewDevice("iPad mini (6th generation)")
                    .previewInterfaceOrientation(.portraitUpsideDown)

            }
            .previewDevice("iPhone 11")
        } else {
            // Fallback on earlier versions
        }
    }
}
