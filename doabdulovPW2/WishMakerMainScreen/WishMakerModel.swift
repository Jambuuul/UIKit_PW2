//
//  WishMakerModel.swift
//  doabdulovPW2
//
//  Created by Jam on 09.11.2025.
//

import Foundation
import UIKit

enum WishMakerModel {
    enum Start {
        struct Request {}
        struct Response {}
        
        struct ViewModel {
            let color: UIColor
        }
    }
    
    enum ColorUpdate {
        struct Request {
            let color: UIColor
        }
        
        struct Response {
            let color: UIColor
        }
    }
    enum HexColorUpdate {
        struct Request {
            let hex: String
        }
    }
}
