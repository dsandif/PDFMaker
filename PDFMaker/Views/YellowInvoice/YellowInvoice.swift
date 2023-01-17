//
//  BlackInvoice.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/22/21.
//

import SwiftUI
import Currency

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
            self.exportToPDF()
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "doc.text.fill")
                    .aspectRatio(contentMode: .fit)
                    .font(.body.bold())
                    .foregroundColor(.blue)
                    Text("Export")
            }
        }
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
        .navigationBarItems(leading: btnBack, trailing: btnExport)
        .navigationBarTitleDisplayMode(.inline)
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
//                    invoiceModel.showInvoiceData()
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
            let floatVal: NSString = item.price.amount.description as NSString
            let totalCost = Double((CGFloat(item.quantity) * CGFloat(floatVal.floatValue)))

            HStack{
                Text(item.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Text(item.price.localizedString())
                        .frame(minWidth: 50, maxHeight: .infinity, alignment: .center)
                    Text(String(item.quantity))
                        .frame(minWidth: 50, maxHeight: .infinity, alignment: .center)
                    Text(USD(floatLiteral: totalCost).localizedString())
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
            
            HStack(spacing: 100) {
                Spacer()
                HStack{
                    Text("PAID")
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .leading)
                        
                    Text("$0.00")
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 50)
            .font(.caption)
            Divider()
            HStack(spacing: 100) {
                Spacer()
                HStack{
                    Text("AMOUNT DUE")
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .leading)
                        
                    Text(invoiceModel.getAmountDue.localizedString())
                        .frame(minWidth: 100, maxHeight: .infinity, alignment: .trailing)
                }
            }
            .padding([.horizontal,.bottom], 50)
            .font(.caption.bold())
        }
    }
    func exportToPDF() {

        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("SwiftUI.pdf")

        //Normal with
        let width: CGFloat = 8.5 * 72.0
        //Estimate the height of your view
        let height: CGFloat = CGFloat(1000 + (50*invoiceModel.lineItems.count))
        let charts = self.body

        let pdfVC = UIHostingController(rootView: charts)
        pdfVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)

        //Render the view behind all other views
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        rootVC?.addChild(pdfVC)
        rootVC?.view.insertSubview(pdfVC.view, at: 0)

        //TODO: Create pay now link
//        let font = UIFont.boldSystemFont(ofSize: 25)
//        let string = NSAttributedString(string: "Pay Now", attributes: [
//            .link: URL(string: "https://apple.com")!,
//            .font: font,
//            .strokeColor: UIColor(red: 25, green: 140, blue: 255),
//            .underlineColor: UIColor.clear,
//            .foregroundColor: UIColor(red: 25, green: 140, blue: 255),
//        ])


        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 8.5 * 72.0, height: height))
        DispatchQueue.main.async {
            do {
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                    context.beginPage()
                    pdfVC.view.layer.render(in: context.cgContext)
//                    string.draw(in: context.pdfContextBounds)
                    pdfVC.removeFromParent()
                    pdfVC.view.removeFromSuperview()
                })
                print("wrote file to: \(outputFileURL.path)")
            } catch {
                print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
    }
}

struct BlackInvoice_Previews: PreviewProvider {
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
