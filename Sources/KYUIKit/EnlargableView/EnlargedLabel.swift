//
//  EnlargedLabel.swift
//
//
//  Created by Kyle on 2024/8/13.
//

import UIKit
import KYFoundation

open class EnlargedLabel: UILabel, EnlargableView {
    // Define the extra padding for the tap area
    open var tapAreaInsets: UIEdgeInsets = .zero
    
    public init(tapAreaInsets: UIEdgeInsets) {
        self.tapAreaInsets = tapAreaInsets
        super.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        contains(point: point)
    }
    
    open override func layoutSubviews() {
        updateTagViewIfNeeded()
        super.layoutSubviews()
    }
}
