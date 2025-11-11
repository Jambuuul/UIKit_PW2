//
//  CustomTextField.swift
//  doabdulovPW2
//
//  Created by Jam on 10.11.2025.
//

import Foundation
import UIKit

final class CustomTextField: UIView {
    
    private enum Const {
        static let cornerRadius: CGFloat = 5
    }
    
    
    public var placeholder: String {
        get {
            return textField.placeholder ?? ""
        }
        set {
            textField.placeholder = newValue
        }
    }
    private let stack = UIStackView()
    public let textField = UITextField()
    public let sendButton = UIButton(type: .system)
    
    init() {
        super.init(frame: .zero)
        configureUI()
        
    }
    
    private func configureUI() {
        backgroundColor = .white
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.layer.cornerRadius = Const.cornerRadius
        layer.cornerRadius = Const.cornerRadius
        
        addSubview(stack)
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(sendButton)
        
        sendButton.setImage(UIImage(systemName:"arrow.right.circle.fill"), for: .normal)
        sendButton.backgroundColor = .blue
        
        stack.pinTop(to: topAnchor)
        stack.pinCenterX(to: centerXAnchor)
        stack.pinTop(to: topAnchor)
        stack.pinLeft(to: leadingAnchor)
        stack.pinBottom(to: bottomAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
