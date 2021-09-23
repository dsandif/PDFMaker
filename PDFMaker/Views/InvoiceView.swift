//
//  InvoiceView.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/21/21.
//

import SwiftUI

import SwiftUI

struct InvoiceView: View {
    let items: [InvoiceItem] = [
        InvoiceItem(description: "test item", price: 200.00),
        InvoiceItem(description: "test item", price: 200.00),
        InvoiceItem(description: "test item", price: 200.00),
        InvoiceItem(description: "test item", price: 200.00),
        InvoiceItem(description: "test item", price: 200.00),
        InvoiceItem(description: "test item", price: 200.00),
        InvoiceItem(description: "test item", price: 200.00),
        InvoiceItem(description: "test item", price: 200.00),
        InvoiceItem(description: "test item", price: 200.00)
    ]
    
    var myDivider: some View{
        Divider()
            .background(Color.white)
            
    }
    
    var dashedDivider: some View{
        Divider()
            .opacity(0)
            .overlay(Rectangle().stroke(style: StrokeStyle(lineWidth: 0.6, dash: [1.5])))
    }
    var topHeading: some View{
        HStack{
            VStack(alignment: .leading){
                Text("Company Intl., LLC")
                    .fontWeight(.thin)
                    .font(.title)
                
                Text("companywebsite.com")
                    .fontWeight(.heavy)
                    .font(.system(size: 8))
            }
            Spacer()
        }
    }
    
    var clientInformation: some View{
        HStack{
            VStack(alignment: .leading){
                Text("To: Client Name")
                    .fontWeight(.light)
                Text(verbatim: "client@dudesemail.com")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
            }
            
            Spacer()
            VStack(alignment: .trailing){
                Text("Invoice: #8675309")
                    .fontWeight(.light)
                Text("companywebsite.com")
                    .fontWeight(.heavy)
            }
        }
    }
    
    var workCompleted: some View{
        VStack(alignment: .center, spacing: 18){
            Text("Work Completed")
                .fontWeight(.light)
                .font(.system(size: 7).lowercaseSmallCaps())
                .padding([.vertical,.horizontal], 3.5)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 0.5)
                )

            VStack{
                ForEach(items, id: \.id){ item in
                    LineItemView(item: item)

                    myDivider
                        .opacity(0.4)
                }
            }
        }
    }
    
    var paymentArea: some View{
        VStack(spacing: 20){
            Text("total: $10000")
                .fontWeight(.heavy)
            
            payNowbtn
        }
        .font(.title3.smallCaps())
        .foregroundColor(.white.opacity(0.8))
    }
    
    var payNowbtn: some View{
        Button(action: {}, label: {
            Text("Pay Now")
                .foregroundColor(.blue)
                .fontWeight(.heavy)
                
        })
        .frame(width: 100, height: 30, alignment: .center)
        .background(Color.white)
        .cornerRadius(20)
    }
    
    
    var body: some View {
        ZStack{
            Color.skyBlue
            ScrollView{
                VStack(spacing: 4){
                    Group{
                        Spacer()
                        topHeading
                        Spacer()
                        dashedDivider
                        Spacer()
                    }
                    
                    Group{
                        clientInformation
                            .font(.system(size: 10))
                        
                        Spacer()
                        myDivider
                        Spacer()
                    }
                    
                    Group{
                        workCompleted
                        
                        Spacer()
                        
                        paymentArea
                        Spacer()
                    }
                }
                .frame(maxWidth: 600, maxHeight: 800)
                .padding(.horizontal, 10)
            }
        }
        .statusBar(hidden: true)
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.white.opacity(0.8))
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        InvoiceView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
        InvoiceView()
            .previewDevice(PreviewDevice(rawValue: "IPad Air 4th generation"))
            .previewDisplayName("IPad Air (4th generation)")
    }
}
