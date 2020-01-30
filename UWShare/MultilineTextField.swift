//
//  MultilineTextField.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-29.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI

struct MultilineTextField: UIViewRepresentable {
    typealias UIViewType = UITextView
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<MultilineTextField>) -> UITextView {
        let multilineTextField = UITextView()
        multilineTextField.textContainer.lineFragmentPadding = 0
        multilineTextField.textContainerInset = .zero
        return multilineTextField
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultilineTextField>) {
        uiView.text = text
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> MultilineTextField.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextField
        init(_ parent: MultilineTextField) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

