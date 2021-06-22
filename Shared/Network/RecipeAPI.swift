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
    
    case postRecipe(recipe: Recipe)
    case postIngredient(ingredient: Ingredient)
    case postStage(stage: Stage)
    
    case deleteRecipe(recipe: Recipe)
    
    var server: String {
       return "http://localhost:4000"
    }
    
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
        case .postRecipe:
            return nil
        case .postIngredient:
            return nil
        case .postStage:
            return nil
        case .deleteRecipe:
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
        case .postRecipe:
            return .post
        case .postIngredient:
            return .post
        case .postStage:
            return .post
        case .deleteRecipe:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .fetchRecipes:
            return "/api/craftbeer/recipes"
        case .fetchIngredient(let recipe):
            let url = "/craftbeer/recipe/\(recipe)/ingredients"
            return url
        case .fetchStage(let recipe):
            let url = "/craftbeer/recipe/\(recipe)/stages"
            return url
        case .updateRecipe(let recipe):
            let id = recipe.id ?? -1
            let url = "/craftbeer/recipe/\(id)"
            return url
        case .postRecipe:
            let url = "/craftbeer/recipe"
            return url
        case .postIngredient:
            let url = "/craftbeer/ingredient"
            return url
        case .postStage:
            let url = "/craftbeer/stage"
            return url
        case .deleteRecipe(let recipe):
            let id = recipe.id ?? -1
            let url = "/craftbeer/recipe/\(id)"
            return url
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try server.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
       
        //Http method
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        switch self  {
        case .updateRecipe(let body):
            let jsonBody = try? JSONEncoder().encode(body)
            print(String(data: jsonBody!, encoding: .utf8) ?? "")
            urlRequest.httpBody = jsonBody
            break;
        case .postRecipe(let body):
            let jsonBody = try? JSONEncoder().encode(body)
            print(String(data: jsonBody!, encoding: .utf8) ?? "")
            urlRequest.httpBody = jsonBody
            break;
        case .postIngredient(let body):
            let jsonBody = try? JSONEncoder().encode(body)
            print(String(data: jsonBody!, encoding: .utf8) ?? "")
            urlRequest.httpBody = jsonBody
            break;
        case .postStage(let body):
            let jsonBody = try? JSONEncoder().encode(body)
            print(String(data: jsonBody!, encoding: .utf8) ?? "")
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

