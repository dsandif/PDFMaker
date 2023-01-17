//
//  InvoiceDataEntry.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/23/21.
//

import SwiftUI
import Currency
import Combine

struct InvoiceDataEntry: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var data: InvoiceModel = InvoiceModel()
    @State var showPreviewButton = false
    let rowHeight = 30.0
    
    var body: some View {
        Form{
            invoiceDataSection
            billFromSection
            billToSection
            lineItemsSection
            previewSection
        }
        .preferredColorScheme(.light)
        .onDisappear(perform: {
            data.resetShownSections()
        })
        .navigationBarHidden(
            data.showLineItemSection == false ||
            data.showBillToSection == false ||
            data.showBillFromSection == false ||
            data.showInvoiceDataSection == false
        )
    }
    
    @ViewBuilder
    var invoiceDataSection: some View {
        if(data.showInvoiceDataSection){
            Section(header: Text("Enter Invoice Info")){
                HStack{
                    TextField("Date", text: $data.invoiceDate)
                        .onChange(of: data.invoiceDate) { inputVal in
                            let dateChars = "##.##.####"
                            data.invoiceDate = data.invoiceDate.applyPatternOnNumbers(pattern: dateChars, replacmentCharacter: "#")

                            if inputVal.count > dateChars.count {
                                data.invoiceDate = String(inputVal.prefix(dateChars.count))
                            }
                        }
                        .keyboardType(.numberPad)
                        .frame(width: 220)
                    Text("|")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    TextField("Invoice #", text: $data.invoiceNumber)
                    .keyboardType(.numberPad)
                }
            }
        }
    }
    
    @ViewBuilder
    var billFromSection: some View {
        if(data.showBillFromSection){
            Section(header: Text("Enter Your Information")){
                HStack{
                    TextField("First Name", text: $data.fromFirstname)
                        .keyboardType(.alphabet)
                        .autocapitalization(.allCharacters)
                    Text("|")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    TextField("Last Name", text: $data.fromLastname)
                        .keyboardType(.alphabet)
                        .autocapitalization(.allCharacters)
                }
                TextField("Street Address", text: $data.fromAddress)
                    .keyboardType(.alphabet)
                HStack{
                    Picker("", selection: $data.fromState, content: {
                        ForEach(USState.allStateAbbreviations, id: \.self, content: { state in
                            Text(state)
                        })
                    })
                    .pickerStyle(.menu)
                    Text("|")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    TextField("City", text: $data.fromCity).keyboardType(.alphabet)
                    Text("|")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    TextField("Zip", text: $data.fromZip)
                        .keyboardType(.numberPad)
                        .onChange(of: data.fromZip) { inputVal in
                            if inputVal.count > 5 {
                                data.fromZip = String(inputVal.prefix(5))
                            }
                        }
                }
                TextField("Phone", text: $data.fromPhone)
                    .onChange(of: data.fromPhone){ inputVal in
                        let phoneChars = "###.###.####"
                        data.fromPhone = data.fromPhone.applyPatternOnNumbers(pattern: phoneChars, replacmentCharacter: "#")

                        if inputVal.count > phoneChars.count {
                            data.fromPhone = String(inputVal.prefix(phoneChars.count))
                        }
                    }
                    .keyboardType(.numberPad)
            }
        }

    }
    
    @ViewBuilder
    var billToSection: some View {
        if(data.showBillToSection){
            Section(header: Text("Enter Payer Information")){
                HStack{
                    TextField("First Name", text: $data.toFirstname)
                        .keyboardType(.alphabet)
                        .autocapitalization(.allCharacters)
                    Text("|")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    TextField("Last Name", text: $data.toLastname)
                        .keyboardType(.alphabet)
                        .autocapitalization(.allCharacters)
                }
                TextField("Street address", text: $data.toAddress)
                    .keyboardType(.alphabet)
                HStack{
                    Picker("", selection: $data.toState, content: {
                        ForEach(USState.allStateAbbreviations, id: \.self, content: { state in
                            Text(state)
                        })
                    })
                    .pickerStyle(.menu)
                    Text("|")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    TextField("City", text: $data.toCity) { (onChanged) in
                    }.keyboardType(.alphabet)
                    Text("|")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    TextField("Zip", text: $data.toZip)
                        .onChange(of: data.toZip) { inputValue in
                            if inputValue.count > 5 {
                                data.toZip = String(inputValue.prefix(5))
                            }
                        }
                        .keyboardType(.numberPad)
                }
                TextField("Phone", text: $data.toPhone)
                    .onChange(of: data.toPhone){ inputVal in
                        let phoneChars = "###.###.####"
                        data.toPhone = data.toPhone.applyPatternOnNumbers(pattern: phoneChars, replacmentCharacter: "#")

                        if inputVal.count > phoneChars.count {
                            data.toPhone = String(inputVal.prefix(phoneChars.count))
                        }
                    }
                    .keyboardType(.numberPad)
            }
        }
    }
    
    @ViewBuilder
    var lineItemsSection: some View {
        if(data.showLineItemSection){
            Section(header:
                HStack{
                    Text("Items")
                    Spacer()
                    HStack(spacing: 20){
                        Button(action: {
                            let newItem = InvoiceItem(description: "New item", price: USD(floatLiteral: 0.00))
                            data.lineItems.append(newItem)
                        }, label: {
                            Text("Add Item")
                                .bold()
                        })
                        Button(action: {
                            data.lineItems = []
                        }, label: {
                            Text("Clear")
                                .bold()
                        }).foregroundColor(.red)
                    }
                    .font(.caption2)
                    
                }.padding(.horizontal,15)
            ){
                List{
                    ForEach($data.lineItems, id: \.id){ $item in
                        NavigationLink(destination: LineItemEditor(item: $item)){
                            HStack{
                                Text(item.description)
                                Spacer()
                                Text(item.price.localizedString())
                            }
                        }
                    }
                    .onDelete(perform: { indexset in
                        data.lineItems.remove(atOffsets: indexset)
                    })
                }
                .frame(minHeight: (rowHeight+15) * Double(data.lineItems.count))
                .listStyle(PlainListStyle())
            }
            .listRowInsets(EdgeInsets())
            discountSection
        }
    }
    
    @ViewBuilder
    var discountSection: some View {
        Section(header:
            HStack{
                Text("Discounts")
                Spacer()
                HStack(spacing: 20){
                    Button(action: {
                        let newItem = InvoiceItem(description: "New discount", price: USD(floatLiteral: 0.00), quantity: 1.0)
                        data.discounts.append(newItem)
                    }, label: {
                        Text("Add discount")
                            .bold()
                    })
                    Button(action: {
                        data.discounts = []
                    }, label: {
                        Text("Clear")
                            .bold()
                    }).foregroundColor(.red)
                }
                .font(.caption2)
            }.padding(.horizontal,15)
        ){
            VStack{
                List{
                    ForEach($data.discounts, id: \.id){$item in
                        NavigationLink(destination: LineItemEditor(item: $item, showQty: false)){
                            HStack{
                                Text(item.description)
                                Spacer()
                                Text(item.price.localizedString())
                            }
                        }
                    }.onDelete(perform: { indexset in
                        data.discounts.remove(atOffsets: indexset)
                    })
                }
                .frame(minHeight: (rowHeight+15) * Double(data.discounts.count))
                .listStyle(PlainListStyle())
            }
        }.listRowInsets(EdgeInsets())
    }
    
    @ViewBuilder
    var previewSection: some View {
        if(showPreviewButton){
            Section(){
                NavigationLink(destination: YellowInvoice(invoiceModel: data)){
                    RoundedButton()
                        .padding()
                }
            }
        }
    }
}
extension String {

    mutating func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: self)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

struct InvoiceDataEntry_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            InvoiceDataEntry()
                .preferredColorScheme(.dark)
                .previewDevice("iPad mini (6th generation)")
                .previewInterfaceOrientation(.portrait)
        } else {
            // Fallback on earlier versions
        }
    }
}
