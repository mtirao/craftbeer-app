//
//  RecipeViewModel.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/10/2020.
//

import Foundation
import SwiftUI

class RecipeViewModel: Identifiable, ObservableObject {
 
    var recipe: Recipe {
        
        let abv = self.recipeAbv
                    .replacingOccurrences(of: "%", with: "")
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let val = formatter.number(from: abv)?.floatValue ?? 0
        
        
        let recipe = Recipe(id: self.recipeId,
                            name: self.recipeName,
                            color: Int(self.recipeColor) ?? 0,
                            ibu: Int(self.recipeIbu) ?? 0,
                            abv: Int(val),
                            style: self.recipeStyle)
        return recipe
    }
    
    private(set) var recipeName: String
    private(set) var recipeStyle: String
    private(set) var recipeAbv: String
    private(set) var recipeColor: String
    private(set) var recipeIbu: String
    
    let recipeId: Int?
    
    init(recipe: Recipe) {
        
        self.recipeId = recipe.id 
        
        self.recipeName = recipe.name ?? ""
        self.recipeStyle = recipe.style ?? ""
        self.recipeAbv = String(recipe.abv ?? 0)
        self.recipeColor = String(recipe.color ?? 0)
        self.recipeIbu = String(recipe.ibu ?? 0)
        
    }
    
    init() {
        recipeId = nil
        
        self.recipeName = ""
        self.recipeStyle = ""
        self.recipeAbv = "0"
        self.recipeColor = "0"
        self.recipeIbu = "0"
    }
    
    init(recipeId: Int?) {
        self.recipeId = recipeId
        self.recipeName = ""
        self.recipeStyle = ""
        self.recipeAbv = "0"
        self.recipeColor = "0"
        self.recipeIbu = "0"
    }
    
    func name(recipe: String) -> RecipeViewModel {
        
        self.recipeName = recipe
        return self
    }
    
    func style(recipe: String) -> RecipeViewModel {
        
        self.recipeStyle = recipe
        return self
    }
    
    func abv(recipe: String) -> RecipeViewModel {
        
        self.recipeAbv = recipe.replacingOccurrences(of: ",", with: "")
        return self
    }
    
    func color(recipe: String) -> RecipeViewModel {
        
        self.recipeColor = recipe
        return self
    }
    
    func ibu(recipe: String) -> RecipeViewModel {
        
        self.recipeIbu = recipe
        return self
    }
    
}
