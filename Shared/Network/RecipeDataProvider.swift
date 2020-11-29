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
    @Published var stageList: [StageViewModel] = []
    
    init() {
        
    }
    
    func updateRecipe(recipe: RecipeViewModel) {
        
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
    
    //Fetch Ingredient and Stage
    func fetchAll(recipe: Int) {
        //Fetch ingredient
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
        
        //------
        
        AF.request(RecipeAPI.fetchStage(recipe: recipe)).responseDecodable{[weak self](response: DataResponse<[Stage], AFError>) in
            
            switch response.result {
            case .success:
                if let stages = response.value {
                    self?.stageList = stages.map(StageViewModel.init)
                }
                break;
            case .failure:
                print("Error")
                break;
            }
        }
        
    }
}


