//
//  EnlargableView.swift
//
//
//  Created by Kyle on 2024/8/13.
//

import KYFoundation
import UIKit

protocol EnlargableView: UIView {
    var tapAreaInsets: UIEdgeInsets { get set }
}

extension EnlargableView {
    func contains(point: CGPoint) -> Bool {
        let largerArea = bounds.inset(by: tapAreaInsets.inverted())
        return largerArea.contains(point)
    }
    
    func updateTagViewIfNeeded() {
        #if DEBUG
        let largerArea = bounds.inset(by: tapAreaInsets.inverted())
        if Env.showHotAreaMask {
            if let tagView = subviews.first(where: { $0.tag == Env.hotAreaMaskViewTag }) {
                tagView.frame = largerArea
            } else {
                let tagView = UIView(frame: largerArea)
                tagView.tag = Env.hotAreaMaskViewTag
                tagView.isUserInteractionEnabled = false
                let color = UIColor(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: Double.random(in: 0.3...0.5))
                tagView.backgroundColor = color
                addSubview(tagView)
            }
        } else {
            subviews
                .filter { $0.tag == Env.hotAreaMaskViewTag }
                .forEach { $0.removeFromSuperview() }
        }
        #endif
    }
}

extension UIEdgeInsets {
    func inverted() -> UIEdgeInsets {
        UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}
