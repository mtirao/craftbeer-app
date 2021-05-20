//
//  IngredientViewModel.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 01/11/2020.
//

import Foundation

class IngredientViewModel: Identifiable {

    var ingredient: Ingredient {
        
        let ing = Ingredient(id: self.ingredientId,
                recipe: recipe,
                name: ingredientN,
                type: ingredientT,
                unit: ingredientU,
                value: ingredientV)
        return ing
    }
    
    private let ingredientId: Int?
    private var recipe: Int?
    private var ingredientN: String?
    private var ingredientT: TypeEnum?
    private var ingredientU: UnitEnum?
    private var ingredientV: Int?
    
    init(ingredient: Ingredient) {
        self.ingredientId = ingredient.id
        self.recipe = ingredient.recipe
        self.ingredientN = ingredient.name
        self.ingredientT = ingredient.type
        self.ingredientU = ingredient.unit
        self.ingredientV = ingredient.value
        
    }
    
    init(recipe: Int?) {
        self.ingredientId = nil
        self.recipe = recipe
        self.ingredientN = nil
        self.ingredientT = nil
        self.ingredientU = nil
        self.ingredientV = nil
    }

    //MARK:- Value in formatted text
    var nameT: String {
        return ingredient.name ?? ""
    }
    
    var valueT: String {
        let val = Float(ingredient.value ?? 0) / 100
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let str = formatter.string(from: NSNumber(value: val)) ?? ""
        return "\(str)"
    }
    
    var unitT: String {
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
    
    var typeT: String {
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
    
    //MARK:- Builder pattern function
    func recipe(id: Int) -> IngredientViewModel {
        self.recipe = id
        return self
    }
    
    func name(ingredient: String) -> IngredientViewModel {
        self.ingredientN = ingredient
        return self
    }
    
    func value(value: String) -> IngredientViewModel {
        self.ingredientV = Int(value)
        return self
    }
    
    func unit(unit: Int) -> IngredientViewModel {
        self.ingredientU = UnitEnum(rawValue: unit + 1)
        return self
    }
    
    func type(type: String) -> IngredientViewModel {
        self.ingredientT = TypeEnum(rawValue: type.lowercased())
        return self
    }
}
