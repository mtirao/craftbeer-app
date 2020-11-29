//
//  RecipeAPI.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/10/2020.
//

import Foundation
import Alamofire

enum RecipeAPI: ApiConfiguration {
    
    case fetchRecipes
    case fetchIngredient(recipe: Int)
    case fetchStage(recipe: Int)
    
    case updateRecipe(recipe: Recipe)
    
    var param: Parameters? {
        switch self {
        case .fetchRecipes:
            return nil
        case .fetchIngredient:
           return nil
        case .fetchStage:
            return nil
        case .updateRecipe:
            return nil
        }
    }
   
    var method: HTTPMethod {
        switch self {
        case .fetchRecipes:
            return .get
        case .fetchIngredient:
            return .get
        case .fetchStage:
            return .get
        case .updateRecipe:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .fetchRecipes:
            return "/craftbeer/recipes"
        case .fetchIngredient(let recipe):
            let url = "/craftbeer/recipe/\(recipe)/ingredients"
            return url
        case .fetchStage(let recipe):
            let url = "/craftbeer/recipe/\(recipe)/stages"
            return url
        case .updateRecipe(let recipe):
            let url = "/craftbeer/recipe/\(String(describing: recipe.id))"
            return url
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try DataProvider.server.rawValue.asURL()
        
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
       
        //Http method
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        switch self  {
        case .updateRecipe(let body):
            let jsonBody = try? JSONEncoder().encode(body)
            urlRequest.httpBody = jsonBody
            break;
        default:
            break
        }
            
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: nil)
    }
    
    
}

