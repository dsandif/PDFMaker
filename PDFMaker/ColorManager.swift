//
//  ColorManager.swift
//  Net Estate
//
//  Created by Darien Sandifer on 7/31/21.
//

import Foundation
import SwiftUI

extension Color{
    static let mediumGreen = Color("mediumGreen")
    static let lightGreen = Color("lightGreen")
    static let paleOrange = Color("paleOrange")
    static let backgroundBlue = Color("darkBlue")
    static let slateBlue = Color("slateBlue")
    static let lightBlue = Color("lightBlue")
    static let lightPink = Color("lightPink")
    static let darkGrey = Color("darkGrey")
    static let flatGreen = Color("flatGreen")
    static let darkGreen = Color("darkGreen")
    static let teal = Color("teal")
    static let brilliantViolet = Color("brilliantViolet")
    static let craftBrown = Color("craftBrown")
    static let fluorescentPink = Color("fluorescentPink")
    static let kiwiGreen = Color("kiwiGreen")
    static let mauvePurple = Color("mauvePurple")
    static let orangeYellow = Color("orangeYellow")
    static let hellRot = Color("hellRot")
    static let lemansBlue = Color("lemansBlue")
    static let darkModeText = Color("darkModeText")
    static let darkModeHeaderText = Color("darkModeHeaderText")
    static let paleDarkBlue = Color("paleDarkBlue")
    static let listAppearance = Color("listAppearance")
    static let listTextAppearance = Color("listTextAppearance")
    static let skyBlue = Color("skyBlue")
    static let remindertext = Color("reminderText")
    static let reminderBackground = Color("reminderBackground")
    static let iceWhite = Color("iceWhite")
    static let dashboardBackground = Color("dashboardBackground")
    static let tungsten = Color("tungsten")
}


class Theme {
    static func navigationBarColors(background : UIColor?,
       titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        navigationAppearance.shadowImage = nil // remove line underneathe
        navigationAppearance.shadowColor = .none
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
       
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}
