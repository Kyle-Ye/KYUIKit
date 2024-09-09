//
//  ContentView.swift
//  KYUIKitDebugApp
//
//  Created by Kyle on 2024/5/29.
//

import SwiftUI
import KYUIKit
import KYFoundation

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    TextInputViewPreview()
                } label: {
                    Text("TextInputView")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
