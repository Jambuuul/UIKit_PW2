//
//  File.swift
//  doabdulovPW2
//
//  Created by Jam on 09.11.2025.
//

import Foundation

protocol WishMakerBusinessLogic {
    typealias Model = WishMakerModel
    
    func loadStart(_ request: Model.Start.Request)
    func getRandomColor()
    func getColorFromSliders(_ request: Model.ColorUpdate.Request)
    func getColorFromHex(_ request: Model.HexColorUpdate.Request)
}

protocol WishMakerPresentationLogic {
    typealias Model = WishMakerModel
    
    func presentStart(_ response: Model.Start.Response)
    func updateColorWithAnimation(_ response: Model.ColorUpdate.Response)
    func updateColorWithoutAnimation(_ response: Model.ColorUpdate.Response)
    
}
