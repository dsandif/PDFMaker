//
//  ContentView.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/21/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass)
    var horizontalSizeClass: UserInterfaceSizeClass?
    var copySize: CGFloat{
        horizontalSizeClass == .compact ? 25 : 50
    }
    var textSize: CGFloat{
        horizontalSizeClass == .compact ? 25 : 35
    }
    var copyPadding: CGFloat{
        horizontalSizeClass == .compact ? 20 : 40
    }
    
    var body: some View {
        ZStack{
            Color.lightGreen
            
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading, spacing: -10){
                        Text("Save.".uppercased())
                            .fontWeight(.heavy)
                            .foregroundColor(.teal)
                        Text("Send.".uppercased())
                            .fontWeight(.heavy)
                            .foregroundColor(.teal)
                        Text("Print.".uppercased())
                            .fontWeight(.heavy)
                            .foregroundColor(.teal)
                        Text("create beautifully designed pdfs on the go.")
                            .fontWeight(.light)
                            .font(.body)
                            .padding(.top)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                .padding([.leading,.top], copyPadding)
                .padding([.bottom], 15)
                .font(Font.custom("Overpass", size: copySize))
                .background(Color.white.opacity(0.2).cornerRadius(10))
                Spacer()

                HStack{
                    Spacer()
                    VStack(alignment: .leading, spacing: 8){
                        NavigationLink(destination: InvoiceDataEntry(showPreviewButton: true)){
                            HStack(spacing: 20){
                                ImageTileView(category: Category.taxes)
                                Text("Create Invoice")
                                    .fontWeight(.heavy)
                                    
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
            }
            .font(Font.custom("Overpass", size: textSize))
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad (8th generation)")
    }
}
