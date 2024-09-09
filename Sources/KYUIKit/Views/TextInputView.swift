//
//  TextInputView.swift
//
//
//  Created by Kyle on 2024/8/15.
//

import UIKit
import SwiftUI

open class TextInputView: UITextView {
    private var _inputAccessoryViewController: UIInputViewController?
    private var _inputViewController: UIInputViewController?
    
    override public var inputAccessoryViewController: UIInputViewController? {
        get {
            _inputAccessoryViewController
        }
        set {
            _inputAccessoryViewController = newValue
        }
    }
    
    override public var inputViewController: UIInputViewController? {
        get {
            _inputViewController
        }
        set {
            _inputViewController = newValue
        }
    }
    
    public func setInputAccessoryView(height: CGFloat, backgroundColor: UIColor? = nil, @ViewBuilder content: () -> some View) {
        let viewController = InputHostingViewController(rootView: content())
        viewController.preferredContentSize.height = height
        viewController.view.backgroundColor = backgroundColor
        inputAccessoryViewController = viewController
    }
    
    public func setInputView(height: CGFloat, backgroundColor: UIColor? = nil, @ViewBuilder content: () -> some View) {
        let viewController = InputHostingViewController(rootView: content())
        viewController.preferredContentSize.height = height
        viewController.view.backgroundColor = backgroundColor
        inputViewController = viewController
    }
}

// MARK: - InputHostingViewController

// Based on https://gist.github.com/liamnichols/a2e656ae93a597952b4427bcfa371185
/// `UIInputViewController` subclass that wraps a `UIHostingController` allowing you to embed SwiftUI inside `inputAccessoryViewController` and friends.
fileprivate final class InputHostingViewController<Content: View>: UIInputViewController {
    let hostingViewController: UIHostingController<Content>
    
    private class InputViewWithAudioFeedback: UIInputView, UIInputViewAudioFeedback {
        var enableInputClicksWhenVisible: Bool { true }
    }

    init(rootView: Content) {
        self.hostingViewController = UIHostingController(rootView: rootView)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = InputViewWithAudioFeedback()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        addChild(hostingViewController)
        hostingViewController.loadViewIfNeeded()
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingViewController.view)
        NSLayoutConstraint.activate([
            hostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        hostingViewController.didMove(toParent: self)
    }

    override var preferredContentSize: CGSize {
        didSet {
            view.bounds.size.height = preferredContentSize.height
        }
    }
}
