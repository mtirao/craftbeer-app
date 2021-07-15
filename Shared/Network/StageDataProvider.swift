//
//  StageDataProvider.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 30/05/2021.
//

import Combine
import Foundation
import Alamofire


class StageDataProvider: ObservableObject {
 
    @Published var stageList: [StageViewModel] = []
    
    init() {
        
    }
    
    
    //Fetch Stage
    func fetchAll(recipe: Int) {
        //Fetch ingredient
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
