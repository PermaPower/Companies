//
//  ColorExtension.swift
//  Project2
//
//  Created by David on 7/11/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit

// Usage Examples

// let shadowColor = Color.shadow.value
// let shadowColorWithAlpha = Color.shadow.withAlpha(0.5)
// let customColorWithAlpha = Color.custom(hexString: "#123edd", alpha: 0.25).value

enum Color {
    
    case red
    case darkBlue
    case white
    case teal
    case lightblue
    case black
    
    case custom(hexString: String, alpha: Double)
    
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}

extension Color {
    
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {

        case .red:
            instanceColor = UIColor(hexString: "#F74252")
        case .white:
            instanceColor = UIColor(hexString: "#FFFFFF")
        case .darkBlue:
            instanceColor = UIColor(hexString: "#092D40")
        case .teal:
            instanceColor = UIColor(hexString: "#30A4B6")
        case .lightblue:
            instanceColor = UIColor(hexString: "#DAEBF3")
        case .black:
            instanceColor = UIColor(hexString: "#000000")
            
        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
        }
        return instanceColor
    }
}

extension UIColor {
    // Creates an UIColor from HEX String in "#363636" format

    convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
