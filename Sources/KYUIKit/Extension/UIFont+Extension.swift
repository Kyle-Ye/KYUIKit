//
//  UIFont+Extension.swift
//  
//
//  Created by Kyle on 2024/5/20.
//

import UIKit
import KYFoundation

extension KYWrapper where Base == UIFont {
    public func lineSpacing(factor: Double) -> Double {
        base.pointSize * factor - base.lineHeight
    }
}
