//
//  Gradient.swift
//
//
//  Created by Kyle on 2024/4/24.
//

import UIKit

public final class Gradient {
    public var colors: [UIColor]
    public var locations: [Double]?
    public var startPoint: CGPoint?
    public var endPoint: CGPoint?
    
    /// Init a Graident color in UIKit
    /// - Parameters:
    ///   - colors: An optional array of UIColor for the gradient.
    ///   - locations: An optional array of Double defining the location of each gradient stop. Animatable.
    ///   - startPoint: The start point of the gradient when drawn in the layer’s coordinate space. Animatable.
    ///   - endPoint: The end point of the gradient when drawn in the layer’s coordinate space. Animatable.
    public init(colors: [UIColor], locations: [Double]? = nil, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) {
        self.colors = colors
        self.locations = locations
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    public var layer: CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = colors.map { $0.cgColor }
        layer.locations = locations?.map { NSNumber(floatLiteral: $0) }
        if let startPoint { layer.startPoint = startPoint }
        if let endPoint { layer.endPoint = endPoint }
        return layer
    }
    
    public func update(layer: CAGradientLayer) {
        layer.colors = colors.map { $0.cgColor }
        layer.locations = locations?.map { NSNumber(floatLiteral: $0) }
        if let startPoint { layer.startPoint = startPoint }
        if let endPoint { layer.endPoint = endPoint }
    }
    
    private static let smoothColorCoefficient = [0, 0.01, 0.04, 0.08, 0.15, 0.23, 0.33, 0.44, 0.56, 0.67, 0.77, 0.85, 0.92, 0.96, 0.99, 1]
    private static let smoothLocationCoefficient = [0, 0.07, 0.13, 0.2, 0.27, 0.33, 0.4, 0.47, 0.53, 0.6, 0.67, 0.73, 0.8, 0.87, 0.93, 1]
    
    public static func smoothMask(alpha: Double, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) -> Gradient {
        return Gradient(
            colors: smoothColorCoefficient.map { UIColor.clear.withAlphaComponent($0 * alpha) },
            locations: smoothLocationCoefficient,
            startPoint: startPoint,
            endPoint: endPoint
        )
    }
    
    public static func smoothGradient(color: UIColor, alpha: Double, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) -> Gradient {
        return Gradient(
            colors: smoothColorCoefficient.map { color.withAlphaComponent($0 * alpha) },
            locations: smoothLocationCoefficient,
            startPoint: startPoint,
            endPoint: endPoint
        )
    }
}

#if DEBUG
import SwiftUI

@available(iOS 17, *)
struct GradientRepresentable: UIViewRepresentable {
    var gradient: Gradient
    
    func makeUIView(context: Context) -> GradientView {
        let view = GradientView(gradient: gradient)
        return view
    }
    
    func updateUIView(_: GradientView, context _: Context) {}
}

@available(iOS 17, *)
#Preview {
    GradientRepresentable(gradient: .init(colors: [.red, .green]))
}

#endif
