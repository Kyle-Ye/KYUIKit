//
//  TextInputViewPreview.swift
//
//
//  Created by Kyle on 2024/8/15.
//

#if DEBUG
import SwiftUI
import UIKit
import SnapKit

public struct TextInputViewPreview: View {
    public init() {}
    public var body: some View {
        TextInputViewControllerRepresentable()
    }
}

struct TextInputViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = TextInputViewController
    
    func makeUIViewController(context: Context) -> TextInputViewController {
        TextInputViewController()
    }
    
    func updateUIViewController(_ uiViewController: TextInputViewController, context: Context) {
        
    }
}

final class TextInputViewController: UIViewController {
    let manager = Manager()
    
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.contentSize = CGSize(width: 400, height: 800)
        for index in 0 ..< 20 {
            let textView = generateTextView()
            textView.frame = CGRect(x: 0, y: 30 + index * 100, width: 300, height: 50)
            scrollView.addSubview(textView)
            manager.textViews.append(textView)
        }
    }
    
    private func generateTextView() -> UITextView {
        let textView = TextInputView(frame: .zero)
        textView.backgroundColor = .blue
        textView.delegate = self
        textView.setInputAccessoryView(height: 60) { [weak self] in
            if let self {
                Toolbar(manager: manager)
            }
        }
        return textView
    }
    
    struct Toolbar: View {
        @ObservedObject var manager: Manager
        
        var body: some View {
            HStack {
                HStack(spacing: 40) {
                    Button {
                       manager.up()
                    } label: {
                        Image(systemName: "arrow.up")
                    }.disabled(manager.before == nil)
                    Button {
                        manager.down()
                    } label: {
                        Image(systemName: "arrow.down")
                    }.disabled(manager.next == nil)
                }
                .padding()
                Spacer()
                Button("Done") {
                    manager.done()
                }
                .padding()
            }
        }
    }
    
    class Manager: ObservableObject {
        @Published var current: UITextView?
        var textViews: [UITextView] = []
        
        var next: UITextView? {
            let next: UITextView? = if let current, let index = textViews.firstIndex(of: current) {
                textViews[safeIndex: index + 1]
            } else {
                nil
            }
            return next
        }
        
        var before: UITextView? {
            if let current, let index = textViews.firstIndex(of: current) {
                textViews[safeIndex: index - 1]
            } else {
                nil
            }
        }
        
        func up() {
            before?.becomeFirstResponder()
        }
        
        func down() {
            next?.becomeFirstResponder()
        }
        
        func done() {
            current?.resignFirstResponder()
            current = nil
        }
    }
}

extension TextInputViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing")
        manager.current = textView
        
        print("Frame \(textView.frame)")
        scrollView.scrollRectToVisible(textView.frame, animated: true)
    }
}

#Preview {
    TextInputViewPreview()
}
#endif
