//
//  EnlargableViewPreview.swift
//
//
//  Created by Kyle on 2024/8/12.
//

#if DEBUG

import SwiftUI
@_spi(DEBUG) import KYFoundation
import CompactSlider

public struct EnlargableViewPreview: View {
    public init() {}
    public var body: some View {
        EnlargableViewPreviewBody()
    }
}

struct EnlargableViewPreviewBody: View {
    @State private var forceShowHotAreaMask = Env._forceShowHotAreaMask
    
    @State private var topInset = 0.0
    @State private var leftInset = 0.0
    @State private var bottomInset = 0.0
    @State private var rightInset = 0.0
    
    private var range: ClosedRange<Double> { -20.0 ... 20.0 }
    
    private var step: Double { 0.5 }
    
    private var tapAreaInsets: UIEdgeInsets {
        UIEdgeInsets(
            top: CGFloat(topInset),
            left: CGFloat(leftInset),
            bottom: CGFloat(bottomInset),
            right: CGFloat(rightInset)
        )
    }
    
    @State private var count = 0
    
    var body: some View {
        List {
            Section {
                Toggle(isOn: $forceShowHotAreaMask) {
                    Text("Force show hot area mask")
                }.onChange(of: forceShowHotAreaMask) {
                    Env._forceShowHotAreaMask = $0
                }
            }
            Section {
                CompactSlider(value: $topInset, in: range, step: step) {
                    Text("Top \(String(format: "%.1f", topInset))")
                }
                CompactSlider(value: $leftInset, in: range, step: step) {
                    Text("Left \(String(format: "%.1f", leftInset))")
                }
                CompactSlider(value: $bottomInset, in: range, step: step) {
                    Text("Bottom \(String(format: "%.1f", bottomInset))")
                }
                CompactSlider(value: $rightInset, in: range, step: step) {
                    Text("Right \(String(format: "%.1f", rightInset))")
                }
            }
            Section {
                EnlargedButtonView(tapAreaInsets: tapAreaInsets) {
                    count += 1
                }
            } footer: {
                Text("Click count \(count)")
            }
            Section {
                EnlargedViewView(tapAreaInsets: tapAreaInsets) {
                    count += 1
                }
            } footer: {
                Text("Click count \(count)")
            }
        }
    }
}

fileprivate struct EnlargedButtonView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(base: self)
    }
    
    typealias UIViewType = UIView
    
    var tapAreaInsets: UIEdgeInsets
    var action: () -> Void
    
    func makeUIView(context: Context) -> UIView {
        let button = EnlargedButton(tapAreaInsets: tapAreaInsets)
        button.setTitle("Tap me", for: [])
        button.backgroundColor = .orange
        button.addTarget(context.coordinator, action: #selector(Coordinator.action), for: .touchUpInside)
        let container = UIView()
        container.addSubview(button)
        container.backgroundColor = .systemBackground
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        return container
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let button = uiView.subviews.first as! EnlargedButton
        button.tapAreaInsets = tapAreaInsets
        button.setNeedsLayout()
    }
    
    @available(iOS 16.0, *)
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
        proposal.replacingUnspecifiedDimensions(by: CGSize(width: 200, height: 100))
    }
    
    class Coordinator: NSObject {
        var base: EnlargedButtonView
        
        init(base: EnlargedButtonView) {
            self.base = base
        }
        
        @objc func action() {
            base.action()
        }
    }
}

fileprivate struct EnlargedViewView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(base: self)
    }
    
    typealias UIViewType = UIView
    
    var tapAreaInsets: UIEdgeInsets
    var action: () -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = EnlargedView(tapAreaInsets: tapAreaInsets)
        view.backgroundColor = .red
        view.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.action)))
        let container = UIView()
        container.addSubview(view)
        container.backgroundColor = .systemBackground
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        return container
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let view = uiView.subviews.first as! EnlargedView
        view.tapAreaInsets = tapAreaInsets
        view.setNeedsLayout()
    }
    
    @available(iOS 16.0, *)
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
        proposal.replacingUnspecifiedDimensions(by: CGSize(width: 200, height: 100))
    }
    
    class Coordinator: NSObject {
        var base: EnlargedViewView
        
        init(base: EnlargedViewView) {
            self.base = base
        }
        
        @objc func action() {
            base.action()
        }
    }
}

#Preview {
    EnlargableViewPreview()
}

#endif
