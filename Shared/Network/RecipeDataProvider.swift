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
    
    
    let updatedRecipe = PassthroughSubject<RecipeViewModel, Never> ()
    
    init() {
        
    }
    
    func updateRecipe(recipe: RecipeViewModel) {
        

        AF.request(RecipeAPI.updateRecipe(recipe: recipe.recipe)).responseDecodable{[weak self](response: DataResponse<Recipe, AFError>) in
            
            switch response.result {
            case .success:
                if let recipe = response.value {
                    let recipeViewModel = RecipeViewModel(recipe: recipe)
                    self?.updatedRecipe.send(recipeViewModel)
                   
                }
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
        
    }
    
    func post(recipe: RecipeViewModel) {
        
        AF.request(RecipeAPI.postRecipe(recipe: recipe.recipe)).responseDecodable{[weak self](response: DataResponse<Recipe, AFError>) in
            
            switch response.result {
            case .success:
                if let recipe = response.value {
                    let recipeViewModel = RecipeViewModel(recipe: recipe)
                    self?.recipeList.append(recipeViewModel)
                    //self?.updatedRecipe.send(recipeViewModel)
                }
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }
    
    func post(stage: StageViewModel) {
        
        AF.request(RecipeAPI.postStage(stage: stage.stage)).responseDecodable{[weak self](response: DataResponse<Stage, AFError>) in
            
            switch response.result {
            case .success:
                if let stage = response.value {
                    let stageViewModel = StageViewModel(stage: stage)
                    self?.stageList.append(stageViewModel)
                    //self?.updatedRecipe.send(recipeViewModel)
                }
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
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
    
    func delete(recipe: RecipeViewModel) {
        AF.request(RecipeAPI.deleteRecipe(recipe: recipe.recipe)).responseDecodable{(response: DataResponse<Recipe, AFError>) in
            
            switch response.result {
            case .success:
                
                var index = 0
                for i in 0 ..< self.recipeList.count {
                    if self.recipeList[i].recipeId == recipe.recipeId {
                        index = i
                    }
                }
                
                self.recipeList.remove(at: index)
                /*if let recipe = response.value {
                    let recipeViewModel = RecipeViewModel(recipe: recipe)
                    self?.recipeList.append(recipeViewModel)
                   
                }*/
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }
}


