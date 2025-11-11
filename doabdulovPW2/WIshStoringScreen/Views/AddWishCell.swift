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
        static let wrapOffsetV: CGFloat = 10
        static let wrapOffsetH: CGFloat = 5
        
        //MARK: visual
        static let wrapCornerRadius: CGFloat = 8
        static let buttonCornerRadius: CGFloat = 10
        static let textViewCornerRadius: CGFloat = 5
        static let buttonWidth: CGFloat = 100
        
        //MARK: button offsets
        static let buttonOffsetV: CGFloat = 10
        static let buttonOffsetH: CGFloat = 0
        
        //MARK: textView offsets
        static let textViewHeight: CGFloat = 30
        static let textViewOffsetV: CGFloat = 10
        static let textViewOffsetH: CGFloat = 5
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
        textView.backgroundColor = .lightGray
        textView.layer.cornerRadius = Const.textViewCornerRadius
        
        textView.textAlignment = .center
        textView.textAlignment = .left
        textView.refreshControl?.contentVerticalAlignment = .center
        textView.setHeight(Const.textViewHeight)
    }
    
    private func configureAddWishButton() {
        addWishButton.setTitle(Const.buttonTitle, for: .normal)
        
        addWishButton.backgroundColor = .systemGreen
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.layer.cornerRadius = Const.buttonCornerRadius
        
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
        addWishButton.setWidth(Const.buttonWidth)
        
        // textview consraints
        textView.pinVertical(to: wrap, Const.textViewOffsetV)
        textView.pinLeft(to: wrap, Const.textViewOffsetH)
        textView.pinRight(to: addWishButton.leadingAnchor, Const.textViewOffsetH)
    }
    
    @objc
    private func addWishButtonPressed() {
        if (textView.text == "") { return }
        addWish?(textView.text ?? "")
        textView.text = ""
    }
    
    
}
