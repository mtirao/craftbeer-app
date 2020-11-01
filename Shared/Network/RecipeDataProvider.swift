//
//  RecipeDataProvider.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/10/2020.
//

import Combine
import Foundation
import Alamofire


class RecipeDataProvider: ObservableObject {
    
    @Published var recipeList: [RecipeViewModel] = []
    @Published var ingredientList: [IngredientViewModel] = []
    
    
    init() {
        
    }
    
    
    func fetchAll() {
        AF.request(RecipeAPI.fetchRecipes).responseDecodable{[weak self](response: DataResponse<[Recipe], AFError>) in
            
            switch response.result {
            case .success:
                if let recipes = response.value {
                    
                    
                    self?.recipeList = recipes.map(RecipeViewModel.init)
                    
                }
                break;
            case .failure:
                print("Error")
                break;
            }
        }
    }
    
    func fetchAll(recipe: Int) {
        AF.request(RecipeAPI.fetchIngredient(recipe: recipe)).responseDecodable{[weak self](response: DataResponse<[Ingredient], AFError>) in
            
            switch response.result {
            case .success:
                if let ingredients = response.value {
                    
                    
                    self?.ingredientList = ingredients.map(IngredientViewModel.init)
                    
                    //self?.objectWillChange.send(self?.recipeList ?? [])
                }
                break;
            case .failure:
                print("Error")
                break;
            }
        }
        
    }
}


