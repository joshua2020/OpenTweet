//
//  UIColour+Extension.swift
//  NotTwitter
//
//  Created by Joshua on 11/12/2022.
//

import Foundation
import UIKit

extension UIColor {

    convenience init(hexString: String) {
        let hexint = UIColor.intFrom(hexString: hexString)
        self.init(red: CGFloat((hexint & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hexint & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hexint & 0x000FF) / 255.0,
                  alpha: 1.0)
    }

    private class func intFrom(hexString: String) -> UInt {
        var hexInt: UInt64 = 0
        let scanner: Scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt64(&hexInt)
        return UInt(hexInt)
    }
}
