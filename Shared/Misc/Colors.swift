//
//  Colors.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 08/02/2023.
//

import UIKit


enum Colors {
    
    case itemBlue
    case wanakaRed
    
    var uiColor : UIColor! {
        switch self {
        case .itemBlue:
                return UIColor(named: "item_blue")
        case .wanakaRed:
                return UIColor(named: "wannaka_red")
        }
    }
}
