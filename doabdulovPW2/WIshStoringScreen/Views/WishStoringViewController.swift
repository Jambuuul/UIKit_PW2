//
//  WishStoringViewController.swift
//  doabdulovPW2
//
//  Created by Jam on 11.11.2025.
//

import UIKit

final class WishStoringViewController: UIViewController {
    private enum Const {
        static let tableCornerRadius: CGFloat = 15
        static let tableOffset: CGFloat = 20
        
        //MARK: table consts
        static let numberOfSections: Int = 2
        
        
        
        //MARK: sections
        static let addWishSection: Int = 0
        static let numberOfAddWishCells: Int = 1
        
        static let UDSaveKey: String = "WishArray"
    }
    
    private let defaults = UserDefaults.standard

    private var wishArray: [String] = [""]
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        
        wishArray = defaults.stringArray(forKey: Const.UDSaveKey) ?? []
        configureTable()
        
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Const.tableCornerRadius
        
        table.pin(to: view, Const.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    private func addWish(with text: String) {
        wishArray.append(text)
        saveChanges()
        table.reloadData()
    }
    
    private func deleteWish(at ind: Int) {
        wishArray.remove(at: ind)
        saveChanges()
        table.reloadData()
    }
    
    
    private func saveChanges() {
        defaults.set(wishArray, forKey: Const.UDSaveKey)
    }
}

//MARK: table data source extension
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Const.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Const.addWishSection: return Const.numberOfAddWishCells
        default:
            return wishArray.count
            
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        switch indexPath.section {
        case Const.addWishSection:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            guard let addWishCell = cell as? AddWishCell else {return cell}
            addWishCell.addWish = addWish
            
            
            return addWishCell
        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath)
            
            guard let wishCell = cell as? WrittenWishCell else {return cell}
            
            wishCell.configure(with: wishArray[indexPath.row])

            
            wishCell.wishDeleted = { [weak self] in
                self?.deleteWish(at: indexPath.row)
            }
            
            wishCell.wishUpdated = { [weak self] in
                self?.wishArray[indexPath.row] = wishCell.getText()
                self?.saveChanges()
            }
            
            return wishCell
        }        
        
    }
}
