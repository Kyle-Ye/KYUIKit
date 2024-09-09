//
//  UIColor+Extension.swift
//
//
//  Created by Kyle on 2024/4/24.
//

import UIKit
import KYFoundation

extension UIColor: KYProtocol {}

extension KYWrapper where Base == UIColor {
    public enum UIColorHexFormat {
        case rgba
        case argb
    }
    
    public static func hex(_ hex: String, format: UIColorHexFormat = .rgba) -> UIColor {
        var hexRawString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexRawString.hasPrefix("#") {
            hexRawString.removeFirst()
        }
        if hexRawString.hasPrefix("0x") {
            hexRawString.removeFirst(2)
        }
        switch hexRawString.count {
        case 6:
            var rgb: Int64 = 0
            Scanner(string: hexRawString).scanHexInt64(&rgb)
            let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
            let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
            let blue = CGFloat((rgb >> 0) & 0xFF) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        case 8:
            switch format {
            case .rgba:
                var rgba: Int64 = 0
                Scanner(string: hexRawString).scanHexInt64(&rgba)
                let red = CGFloat((rgba >> 24) & 0xFF) / 255.0
                let green = CGFloat((rgba >> 16) & 0xFF) / 255.0
                let blue = CGFloat((rgba >> 8) & 0xFF) / 255.0
                let alpha = CGFloat((rgba >> 0) & 0xFF) / 255.0
                return UIColor(red: red, green: green, blue: blue, alpha: alpha)
            case .argb:
                var argb: Int64 = 0
                Scanner(string: hexRawString).scanHexInt64(&argb)
                let alpha = CGFloat((argb >> 24) & 0xFF) / 255.0
                let red = CGFloat((argb >> 16) & 0xFF) / 255.0
                let green = CGFloat((argb >> 8) & 0xFF) / 255.0
                let blue = CGFloat((argb >> 0) & 0xFF) / 255.0
                return UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }
        default:
            Log.runtimeIssues("Only support 6 or 8 digit for UIColor hex")
            return .clear
        }
    }
}
