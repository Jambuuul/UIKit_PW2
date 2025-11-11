//
//  WishMakerInteractor.swift
//  doabdulovPW2
//
//  Created by Jam on 10.11.2025.
//

import Foundation
import UIKit

final class WishMakerInteractor : WishMakerBusinessLogic {
    
    private enum Const {
        static let hexLength: Int = 6
    }
    
    func getColorFromHex(_ request: Model.HexColorUpdate.Request) {
        var value = request.hex
        if value.count != Const.hexLength + 1 {
            return;
        }
        value = String(value.suffix(Const.hexLength))
        
        let scanner = Scanner(string: value)
        var num: Int64 = 0
        if scanner.scanHexInt64(&num) {
            presenter.updateColorWithAnimation(Model.ColorUpdate.Response(color: UIColor.hexToRgb(from: num)))
//            changeBackgroundColor(to: UIColor.hexToRgb(from: num))
        }
    }
    
    
    private let presenter: WishMakerPresentationLogic
    
    init(presenter: WishMakerPresentationLogic) {
        self.presenter = presenter
    }
    
    func getRandomColor() {
        presenter.updateColorWithAnimation(Model.ColorUpdate.Response(color: UIColor.random))
    }
    
    func getColorFromSliders(_ request: Model.ColorUpdate.Request) {
        presenter.updateColorWithoutAnimation(Model.ColorUpdate.Response(color: request.color))
    }
}
