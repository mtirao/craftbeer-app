//
//  RecipeViewModel.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/10/2020.
//

import Foundation

class RecipeViewModel: Identifiable {
 
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var name: String {
        return recipe.name ?? ""
    }
    
    var style: String {
        return recipe.style ?? ""
    }
    
    var abv: String {
        let val = Float(recipe.abv ?? 0) / 10
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let str = formatter.string(from: NSNumber(value: val)) ?? ""
        return "\(str)%"
    }
    
    var color: String {
        let val = recipe.color ?? 0
        
        return "\(val)"
    }
    
    var ibu: String {
        let val = recipe.ibu ?? 0
        
        return "\(val)"
    }
    
}
