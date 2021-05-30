//
//  IngredientDataProvider.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 30/05/2021.
//

import Combine
import Foundation
import Alamofire

class IngredientDataProvider: ObservableObject {
 
    @Published var ingredientList: [IngredientViewModel] = []
    
    init() {
        
    }
    
    
    //Fetch Ingredient
    func fetchAll(recipe: Int) {
        //Fetch ingredient
        AF.request(RecipeAPI.fetchIngredient(recipe: recipe)).responseDecodable{[weak self](response: DataResponse<[Ingredient], AFError>) in
            
            switch response.result {
            case .success:
                if let ingredients = response.value {
                    
                    self?.ingredientList = ingredients.map(IngredientViewModel.init)
                    
                }
                break;
            case .failure:
                print("Error")
                break;
            }
        }
    }
}
