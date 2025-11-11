//
//  WIshMakerPresenter.swift
//  doabdulovPW2
//
//  Created by Jam on 10.11.2025.
//

import Foundation
import UIKit

final class WishMakerPresenter : WishMakerPresentationLogic {
    weak var view: WishMakerViewController?
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel(color: UIColor.random))
    }
    
    func updateColorWithAnimation(_ response: Model.ColorUpdate.Response) {
        view?.changeBackgroundColor(to: response.color)
    }
    
    func updateColorWithoutAnimation(_ response: Model.ColorUpdate.Response) {
        view?.view.backgroundColor = response.color
    }
    
}
