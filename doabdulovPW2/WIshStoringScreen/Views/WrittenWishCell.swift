//
//  WrittenWishCell.swift
//  doabdulovPW2
//
//  Created by Jam on 11.11.2025.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    
    private enum Const {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 20
        
        
        static let buttonSize: CGFloat = 32
        static let buttonOffsetR: CGFloat = 10
        static let buttonOffsetV: CGFloat = 10
    }
    
    private let wishText: UITextView = UITextView()
    private let editButton: UIButton = UIButton(type: .system)
    private let deleteButton: UIButton = UIButton(type: .system)
    private let confirmationButton: UIButton = UIButton(type: .system)
    
    var wishDeleted: (() -> Void)?
    var wishUpdated: (() -> Void)?
    
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getText() -> String {
        return wishText.text ?? ""
    }
    
    func configure(with wish: String) {
        wishText.text = wish
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Const.wrapColor
        wrap.layer.cornerRadius = Const.wrapRadius
        wrap.pinVertical(to: self.contentView, Const.wrapOffsetV)
        wrap.pinHorizontal(to: self.contentView, Const.wrapOffsetH)
        contentView.layer.cornerRadius = Const.wrapRadius

        // wish text
        wrap.addSubview(wishText)
        wishText.pin(to: wrap, Const.wishLabelOffset)
        wishText.pinVertical(to: wrap, Const.buttonOffsetV)
        wishText.backgroundColor = .white
        wishText.isScrollEnabled = false
        wishText.isEditable = false
        wishText.isSelectable = false
        
        // delete button
        wrap.addSubview(deleteButton)
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.pinRight(to: wrap, Const.buttonOffsetR)
        deleteButton.pinVertical(to: wrap, Const.buttonOffsetV)
        deleteButton.setHeight(Const.buttonSize)
        deleteButton.setWidth(Const.buttonSize)
        
        // edit button
        wrap.addSubview(editButton)
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.pinRight(to: deleteButton.leadingAnchor, Const.buttonOffsetR)
        editButton.pinVertical(to: wrap, Const.buttonOffsetV)
        editButton.setHeight(Const.buttonSize)
        editButton.setWidth(Const.buttonSize)
        
        // confirmation button
        wrap.addSubview(confirmationButton)
        confirmationButton.isHidden = true
        confirmationButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        confirmationButton.pinRight(to: wrap, Const.buttonOffsetR)
        confirmationButton.pinVertical(to: wrap, Const.buttonOffsetV)
        confirmationButton.setHeight(Const.buttonSize)
        confirmationButton.setWidth(Const.buttonSize)
        
        
        // button actions
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        confirmationButton.addTarget(self, action: #selector(confirmationButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func editButtonTapped() {
        deleteButton.isHidden = true
        editButton.isHidden = true
        confirmationButton.isHidden = false
        
        setEditingMode(true)
        wishText.becomeFirstResponder()
    }
    
    @objc
    private func deleteButtonTapped() {
        wishDeleted?()
    }
    
    @objc
    private func confirmationButtonTapped() {
        setEditingMode(false)
        deleteButton.isHidden = false
        editButton.isHidden = false
        confirmationButton.isHidden = true
        
        wishUpdated?()
    }
    
    private func setEditingMode(_ editing: Bool) {
        wishText.isEditable = editing
        wishText.isSelectable = editing
        
        if !editing {
            wishText.resignFirstResponder()
        }
    }
    
}
