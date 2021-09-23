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



import Foundation
import SwiftUI


protocol SystemType {
    var systemNameIcon: String { get }
    var name: String { get }
    var color: Color { get }
}

enum Category: String, CaseIterable, SystemType{
    ///categories
    case maintenance
    case taxes
    case trash
    case water
    case appliances_furnishings
    case electricity
    case gas
    case insurance
    case phone
    case cable_internet
    case tv
    case parking
    case security
    case other
    case unknown
    
    var systemNameIcon: String {
        switch self {
            case .maintenance:
                return "wrench.fill"
            case .taxes:
                return "dollarsign.square"
            case .trash:
                return "trash.circle"
            case .water:
                return "drop.fill"
            case .appliances_furnishings:
                return "house.circle"
            case .electricity:
                return "bolt.fill"
            case .gas:
                return "flame.fill"
            case .insurance:
                return "tornado"
            case .phone:
                return "phone.fill"
            case .cable_internet:
                return "laptopcomputer"
            case .tv:
                return "tv.fill"
            case .parking:
                return "car.fill"
            case .security:
                return "video.fill"
            case .other:
                return "o.square"
            case .unknown:
                return "o.square"
            
        }
    }
    
    var name: String {
        switch self {
            case .maintenance:
                return "maintenance"
            case .taxes:
                return "taxes"
            case .trash:
                return "trash"
            case .water:
                return "water"
            case .appliances_furnishings:
                return "appliances"
            case .electricity:
                return "electric"
            case .gas:
                return "gas"
            case .insurance:
                return "insurance"
            case .phone:
                return "phone"
            case .cable_internet:
                return "cable / internet"
            case .tv:
                return "tv"
            case .parking:
                return "parking"
            case .security:
                return "security"
            case .other:
                return "other"
            case .unknown:
                return "unknown"
                
        }
    }
    
    var color: Color {
        switch self {
        case .maintenance:
            return Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1))
        case .taxes:
            return .orangeYellow
        case .trash:
            return .hellRot
        case .water:
            return .teal
        case .appliances_furnishings:
            return Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        case .electricity:
            return Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        case .gas:
            return .blue
        case .insurance:
            return Color(#colorLiteral(red: 0.2440184057, green: 0.4299907982, blue: 0.310161531, alpha: 1))
        case .phone:
            return .lightPink
        case .cable_internet:
            return .lemansBlue
        case .other:
            return .brilliantViolet
        case .tv:
            return .darkGreen
        case .parking:
            return .craftBrown
        case .security:
            return .fluorescentPink
        default:
            return .mauvePurple
        }
    }
    
}

extension Category: Identifiable{
    var id: String { rawValue }
}
