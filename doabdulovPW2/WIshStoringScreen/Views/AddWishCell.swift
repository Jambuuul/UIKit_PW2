//
//  AddWishCell.swift
//  doabdulovPW2
//
//  Created by Jam on 11.11.2025.
//

import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    private enum Const {
        //MARK: button
        static let buttonTitle: String = "Add wish"

        //MARK: Wrap Offsets
        static let wrapOffsetV: CGFloat = 20
        static let wrapOffsetH: CGFloat = 16
        
        //MARK: visual
        static let wrapCornerRadius: CGFloat = 8
        
        //MARK: button offsets
        static let buttonOffsetV: CGFloat = 5
        static let buttonOffsetH: CGFloat = 0
        
        //MARK: textView offsets
        static let textViewHeight: CGFloat = 50
        static let textViewOffsetV: CGFloat = 10
        static let textViewOffsetH: CGFloat = 10
    }
    
    private let textView: UITextView = UITextView()
    private let addWishButton: UIButton = UIButton(type: .system)
    
    var addWish: ((String) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextView() {
        textView.backgroundColor = .white
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .clear
        textView.setHeight(Const.textViewHeight)
    }
    
    private func configureAddWishButton() {
        addWishButton.setTitle(Const.buttonTitle, for: .normal)
        
        addWishButton.backgroundColor = .red
        
        addWishButton.addTarget(
            self,
            action: #selector(addWishButtonPressed),
            for: .touchUpInside
        )
    }
    
    private func configureUI() {
        configureTextView()
        configureAddWishButton()
        
        selectionStyle = .none
        backgroundColor = .clear
        
        //wrap setup
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        wrap.addSubview(textView)
        wrap.addSubview(addWishButton)
        wrap.backgroundColor = .clear
        
        wrap.pinVertical(to: self.contentView, Const.wrapOffsetV)
        wrap.pinHorizontal(to: self.contentView, Const.wrapOffsetH)
        contentView.layer.cornerRadius = Const.wrapCornerRadius
        
        // button constraints
        addWishButton.pinTop(to: wrap, Const.buttonOffsetV)
        addWishButton.pinRight(to: wrap, Const.buttonOffsetH)
        
        // textview consraints
        textView.pinVertical(to: wrap, Const.textViewOffsetV)
        textView.pinLeft(to: wrap, Const.textViewOffsetH)
        textView.pinRight(to: wrap, Const.textViewOffsetH)
    }
    
    @objc
    private func addWishButtonPressed() {
        addWish?(textView.text ?? "")
        textView.text = ""
    }
    
    
}
