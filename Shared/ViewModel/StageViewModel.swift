//
//  StageViewModel.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 15/11/2020.
//

import Foundation

class StageViewModel: Identifiable {

    private let stage: Stage
    
    init(stage: Stage) {
        self.stage = stage
    }
    
    var type: String {
        switch stage.type {
        case .mash:
            return "Mash"
        case .liquor:
            return "Liquor"
        case .boil:
            return "Boil"
        case .fermentation:
            return "Fermentation"
        case .wash:
            return "Wash"
        case .none:
            return ""
        }
    }
    
    var temp: String {
        let val = Float(stage.temp ?? 0) / 100
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let str = formatter.string(from: NSNumber(value: val)) ?? ""
        return "\(str)º C"
    }
    
    var time: String {
        
        if let time = stage.time {
            return "\(time) min"
        }
        return ""
    }
    
    
}
