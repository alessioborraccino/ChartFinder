//
//  UIColor+Hex.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hexString: String){
        var cleanString = hexString.stringByReplacingOccurrencesOfString("#", withString: "")

        switch cleanString.characters.count {
        case 6:
            cleanString = cleanString.stringByAppendingString("ff")
        case 8:
            break
        default:
            cleanString = "4f616eff"
        }

        var result : UInt32 = 0
        NSScanner(string: cleanString).scanHexInt(&result)

        let red = CGFloat((result >> 24) & 0xFF) / 255.0
        let green = CGFloat((result >> 16) & 0xFF) / 255.0
        let blue = CGFloat((result >> 8) & 0xFF) / 255.0
        let alpha = CGFloat((result >> 0) & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    static func ab_Orange() -> UIColor {
        return UIColor(hexString: "#FFA922")
    }

    static func ab_Yellow() -> UIColor {
        return UIColor(hexString: "#FFD731")
    }

    static func ab_Red() -> UIColor {
        return UIColor(hexString: "#E16F6F")
    }
}
