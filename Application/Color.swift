//
//  Color.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/5/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit

struct Color {
    
    static func colorWithHex(hex: UInt32, alpha: CGFloat) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: alpha)
    }
    
    static func grayDarkest() -> UIColor {
        return colorWithHex(0x232323, alpha: 1.0);
    }
    
}
