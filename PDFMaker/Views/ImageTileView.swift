//
//  AmentityImageView.swift
//  PDFMaker
//
//  Created by Darien Sandifer on 9/21/21.
//

import Foundation
import SwiftUI

enum SelectionMode{
    case active
    case inactive
}

struct ImageTileView: View {
    let category: SystemType
    var selected: Bool = true
    var isSelectionMode: SelectionMode? = .active
    
    var foreground: Color {
        if(isSelectionMode == .inactive) { return category.color}
        else if(isSelectionMode == .active && selected == true) { return category.color}
        else if(isSelectionMode == .active && selected == false) { return Color.white }
        else { return category.color }
    }
    
    var background: Color {
        if(isSelectionMode == .inactive) { return category.color.opacity(0.1) }
        else if(isSelectionMode == .active && selected == true) { return category.color.opacity(0.1) }
        else if(isSelectionMode == .active && selected == false) { return category.color }
        else { return category.color.opacity(0.1) }
    }
    
    var body: some View {
        Image(systemName: category.systemNameIcon)
        .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15)
            .padding(.all, 10)
            .foregroundColor(foreground)
            .background(background)
        .cornerRadius(5)
    }
}

struct ImageTileView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTileView(category: Category.parking)
    }
}




