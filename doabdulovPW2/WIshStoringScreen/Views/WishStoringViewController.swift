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
        view.backgroundColor = .white
        
        wishArray = defaults.stringArray(forKey: Const.UDSaveKey) ?? []
        configureTable()
        startColorBreathing()
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .white
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Const.tableCornerRadius
        table.delegate = self
            
        table.pin(to: view, Const.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    private func addWish(with text: String) {
        wishArray.append(text)
        saveChanges()
        
        
        let newIndexPath = IndexPath(row: wishArray.count - 1, section: 1)
        let rowRect = table.rectForRow(at: newIndexPath)
        let pointInTable = CGPoint(x: rowRect.maxX, y: rowRect.maxY)
        let pointInView = table.convert(pointInTable, to: view)
        showSpark(at: pointInView)
        
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
    
    var colorTimer: Timer?

    private func startColorBreathing() {
        colorTimer?.invalidate()
        colorTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            guard let self else { return }
            UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut, .allowUserInteraction]) {
                self.view.backgroundColor = .random
                self.table.backgroundColor = self.view.backgroundColor
            }
        }
    }
    
    // MARK: - Spark animation
    private func showSpark(at point: CGPoint) { // NEW
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = point
        emitter.emitterShape = .circle
        emitter.emitterSize = CGSize(width: 20, height: 20)

        let cell = CAEmitterCell()
        cell.contents = UIImage(systemName: "sparkles")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
            .cgImage // EN: use SF Symbol as particle
        cell.birthRate = 40
        cell.lifetime = 0.8
        cell.velocity = 120
        cell.velocityRange = 30
        cell.scale = 0.16
        cell.scaleRange = 0.05
        cell.alphaSpeed = -1.0
        cell.emissionRange = .pi * 2 // 360°
        emitter.emitterCells = [cell]

        view.layer.addSublayer(emitter)

        // Auto-remove
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            emitter.birthRate = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                emitter.removeFromSuperlayer()
            }
        }
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
    
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        guard indexPath.section == 1 else { return nil }
        let text = wishArray[indexPath.row]
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let copy = UIAction(title: "Копировать", image: UIImage(systemName: "doc.on.doc")) { _ in
                UIPasteboard.general.string = text
            }
            let share = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
                let vc = UIActivityViewController(activityItems: [text], applicationActivities: nil)
                self?.present(vc, animated: true)
            }
            let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
                self?.deleteWish(at: indexPath.row)
            }
            return UIMenu(title: "", children: [copy, share, delete])
        }
    }


}


extension WishStoringViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        guard indexPath.section != 0 else { return }
        cell.transform = CGAffineTransform(translationX: 0, y: -40)
        cell.alpha = 0
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseOut]) {
            cell.transform = .identity
            cell.alpha = 1
        }
    }
}

