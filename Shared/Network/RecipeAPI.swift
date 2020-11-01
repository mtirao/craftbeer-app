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
    
    var param: Parameters? {
        switch self {
        case .fetchRecipes:
            return nil
        case .fetchIngredient:
           return nil
        }
    }
   
    var method: HTTPMethod {
        switch self {
        case .fetchRecipes:
            return .get
        case .fetchIngredient:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchRecipes:
            return "/craftbeer/recipes"
        case .fetchIngredient(let recipe):
            let url = "/craftbeer/recipe/ingredients/\(recipe)"
            return url
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try DataProvider.server.rawValue.asURL()
        
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
       
        //Http method
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
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

