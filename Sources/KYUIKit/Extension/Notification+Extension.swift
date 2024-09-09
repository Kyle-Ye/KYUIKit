//
//  Notification+Extension.swift
//
//
//  Created by Kyle on 2024/8/11.
//

import Foundation
import KYFoundation
import UIKit

// MARK: - Keyboard Related Extension

extension KYWrapper where Base == Notification {
    /// Check if the keyboard notification is from float keyboard on iPadOS
    public var isFromFloatKeyboard: Bool {
        guard let userInfo = base.userInfo else {
            return false
        }
        if let frame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect, frame == .zero {
            return true
        } else if let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect, frame == .zero {
            return true
        } else {
            return false
        }
    }
    
    public var isFloatKeyboardAppearing: Bool {
        if let userInfo = base.userInfo,
           let frame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
           frame == .zero {
            return true
        } else {
            return false
        }
    }
    
    public var isFloatKeyboardDisappearing: Bool {
        if let userInfo = base.userInfo,
           let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
           frame.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    public var isLocalUser: Bool? {
        base.userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as? Bool
    }
    
    public var keyboardFrameBegin: CGRect? {
        base.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
    }
    
    public var keyboardFrameEnd: CGRect? {
        base.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }
    
    public var keyboardAnimationCurve: UIView.AnimationOptions? {
        (base.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt).map(UIView.AnimationOptions.init(rawValue:))
    }
    
    public var keyboardAnimationDuration: Double? {
        base.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
    }
}
