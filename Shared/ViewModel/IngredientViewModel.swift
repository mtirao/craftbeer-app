//
//  IngredientViewModel.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 01/11/2020.
//

import Foundation

class IngredientViewModel: Identifiable {

    private let ingredient: Ingredient
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
    }
    
    var name: String {
        return ingredient.name ?? ""
    }
    
    var value: String {
        let val = Float(ingredient.value ?? 0) / 100
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let str = formatter.string(from: NSNumber(value: val)) ?? ""
        return "\(str)"
    }
    
    var unit: String {
        switch ingredient.unit {
        case .kilo:
            return "kg."
        case .grams:
            return "gr."
        case .liter:
            return "lt."
        default:
            return ""
        }
    }
    
    var type: String {
        switch ingredient.type {
        case .malt:
            return "Malt"
        case .hop:
            return "Hop"
        case .yeast:
            return "Yeast"
        case .water:
            return "Water"
        default:
            return ""
        }
    }
    
}
