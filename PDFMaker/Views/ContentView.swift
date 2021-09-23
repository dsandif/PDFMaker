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
                        Text("Send.".uppercased())
                            .fontWeight(.heavy)
                        Text("Print.".uppercased())
                            .fontWeight(.heavy)
                        
                        Text("create beautifully designed pdfs on the go.".lowercased())
                            .fontWeight(.light)
                            .font(.body)
                            .padding(.top)

                    }
                    Spacer()
                }
                .padding([.leading,.top], copyPadding)
                .padding([.bottom], 15)
                .font(Font.custom("Overpass", size: copySize))
                .foregroundColor(.black)
                .background(Color.white.opacity(0.2).cornerRadius(10))
                Spacer()

                HStack{
                    Spacer()
                    VStack(alignment: .leading, spacing: 8){
                        NavigationLink(destination: CreateInvoice()){
                            HStack(spacing: 20){
                                ImageTileView(category: Category.maintenance)
                                Text("Create Invoice")
                                    .fontWeight(.heavy)
                                    
                            }
                        }

                        NavigationLink(destination: CreateReport()){
                            HStack(spacing:20){
                                ImageTileView(category: Category.cable_internet)
                                Text("Create Report")
                                    .fontWeight(.heavy)
                            }
                        }
                        
                        NavigationLink(destination: CreateLease()){
                            HStack(spacing:20){
                                ImageTileView(category: Category.cable_internet)
                                Text("Create Lease")
                                    .fontWeight(.heavy)
                            }
                        }
                        NavigationLink(destination: ScanDocument()){
                            HStack(spacing:20){
                                ImageTileView(category: Category.cable_internet)
                                Text("Scan a Doc")
                                    .fontWeight(.heavy)
                            }
                        }

                        NavigationLink(destination: CustomPdf()){
                            HStack(spacing:20){
                                ImageTileView(category: Category.cable_internet)
                                Text("Custom")
                                    .fontWeight(.heavy)
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
//                    .background(Color.white.opacity(0.2).cornerRadius(10))
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
