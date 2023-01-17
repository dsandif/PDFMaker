//
//  CreateInvoice.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/21/21.
//

import SwiftUI
import Currency

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
    }
}
