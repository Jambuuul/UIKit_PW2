//
//  WishMakerAssembly.swift
//  doabdulovPW2
//
//  Created by Jam on 10.11.2025.
//

import Foundation
import UIKit

enum WishMakerAssembly {
    static func build() -> UIViewController {
        let presenter: WishMakerPresenter = WishMakerPresenter()
        let interactor: WishMakerInteractor = WishMakerInteractor(presenter: presenter)
        let viewController: WishMakerViewController = WishMakerViewController(
            interactor: interactor
        )
        
        presenter.view = viewController
        
        return viewController
    }

}
