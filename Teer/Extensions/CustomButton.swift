//
//  CustomButton.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/27/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit

class CustomBtn: UIButton {

    override func awakeFromNib() {
       // roundCustomButton()
        frame = CGRect(x: 40, y: 706, width: 320.04, height: 50)
        layer.cornerRadius = 30.0
        //layer.borderWidth = 0.8
        //layer.shadowColor = (UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.16) as! CGColor)
        //let darkGrey = UIColor(hex:"#D2415B")
        layer.backgroundColor = #colorLiteral(red: 0.84375, green: 0.2552154977, blue: 0.3597818773, alpha: 1)
        
        tintColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
     //   layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.5)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        //layer.cornerRadius = 4.0
        layer.shadowColor = #colorLiteral(red: 0.8391390443, green: 0.8392632604, blue: 0.8391231894, alpha: 1)
        
    }

}
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

    func roundCustomButton(){
        
    
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
//extension UIColor {
////   convenience init(red: Int, green: Int, blue: Int) {
////       assert(red >= 0 && red <= 255, "Invalid red component")
////       assert(green >= 0 && green <= 255, "Invalid green component")
////       assert(blue >= 0 && blue <= 255, "Invalid blue component")
////
////       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
////   }
////
////   convenience init(rgb: Int) {
////       self.init(
////           red: (rgb >> 16) & 0xFF,
////           green: (rgb >> 8) & 0xFF,
////           blue: rgb & 0xFF
////       )
////   }
////}
////    func hexStringToUIColor (hex:String) -> UIColor {
////        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
////
////        if (cString.hasPrefix("#")) {
////            cString.remove(at: cString.startIndex)
////        }
////
////        if ((cString.count) != 6) {
////            return UIColor.gray
////        }
////
////        var rgbValue:UInt64 = 0
////        Scanner(string: cString).scanHexInt64(&rgbValue)
////
////        return UIColor(
////            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
////            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
////            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
////            alpha: CGFloat(1.0)
////        )
////    }
////
//
//    convenience init(hexString: String) {
//        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int = UInt64()
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (255, 0, 0, 0)
//        }
//        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
//    }
//}
