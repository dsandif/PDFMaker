//
//  InvoiceData.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 1/16/23.
//

import Foundation
import SwiftUI
import Currency

struct InvoiceItem: Identifiable, Hashable {
    let id: UUID = UUID()
    var description: String = ""
    var price: USD = USD(0.00)
    var quantity: Double = 0.0
    
    func getAmountForItem() -> USD {
        let floatVal = CGFloat(self.price.minorUnits) / 100.00
        let totalCost = (CGFloat(self.quantity) * floatVal)
        return USD(floatLiteral: totalCost)
    }
}

class InvoiceModel: ObservableObject{
    // Invoice data
    @Published var invoiceNumber = "INV-0001"
    @Published var invoiceDate = "07.20.2022"
    @Published var toFirstname = ""
    @Published var toLastname = ""
    @Published var toCity = ""
    @Published var toState = USState.allStateAbbreviations.first!
    @Published var toPhone = "---"
    @Published var toZip = ""
    @Published var toAddress = ""
    @Published var fromFirstname = ""
    @Published var fromLastname = ""
    @Published var fromCity = ""
    @Published var fromState = USState.allStateAbbreviations.first!
    @Published var fromPhone = "---"
    @Published var fromZip = ""
    @Published var fromAddress = ""
    @Published var fromCountry = ""
    @Published var toCountry = ""
    @Published var discounts: [InvoiceItem] = []
    @Published var lineItems: [InvoiceItem] = [
        InvoiceItem(description: "Milk", price: 5.00, quantity: 2),
        InvoiceItem(description: "Candy", price: 6.00, quantity: 5),
        InvoiceItem(description: "Books", price: 25, quantity: 3),
        InvoiceItem(description: "Pictures", price: 2.00, quantity: 30),
    ]

    //Section Display
    @Published var showBillToSection = true
    @Published var showBillFromSection = true
    @Published var showInvoiceDataSection = true
    @Published var showLineItemSection = true
    
    //Data Export
    var exportURL = ""
    var showExportSheet = false
    var showError = false
    
    // Other displayed data
    var discountAmount: USD {
        return discounts.reduce(0) {
            return ($0 + $1.getAmountForItem())
        }
    }
    
    var getTotal: USD {
        return lineItems.reduce(0) {
            return ($0 + $1.getAmountForItem())
        }
    }
    
    var getAmountDue: USD {
        return (getTotal - discountAmount)
    }
    
    func resetShownSections() {
        showLineItemSection = true
        showBillToSection = true
        showBillFromSection = true
        showInvoiceDataSection = true
    }
    func showBillTo(){
        showBillToSection = true
        showBillFromSection = false
        showInvoiceDataSection = false
        showLineItemSection = false
    }
    
    func showBillFrom(){
        showBillToSection = false
        showBillFromSection = true
        showInvoiceDataSection = false
        showLineItemSection = false
    }
    
    func showInvoiceData(){
        showBillToSection = false
        showBillFromSection = false
        showInvoiceDataSection = true
        showLineItemSection = false
    }
    
    func showLineItems(){
        showBillToSection = false
        showBillFromSection = false
        showInvoiceDataSection = false
        showLineItemSection = true
    }
}
