//
//  StageViewModel.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 15/11/2020.
//

import Foundation

class StageViewModel: Identifiable {

    var stage: Stage {
        
        let stag = Stage(id: self.stageId,
                         recipe: self.stageRecipe,
                         type: self.stageTypeT,
                         temp: self.stageTempT,
                         time: self.stageTimeT)
        
        return stag
    }
    
    
    private let stageId: Int?
    private var stageRecipe: Int?
    private var stageTypeT: StageEnum?
    private var stageTempT: Int?
    private var stageTimeT: Int?
  
    
    init(stage: Stage) {
        
        self.stageId = stage.id
        self.stageRecipe = stage.recipe
        self.stageTypeT = stage.type
        self.stageTempT = stage.temp
        self.stageTimeT = stage.time
        
    }
    
    init(recipe: Int?) {
        self.stageRecipe = recipe
        self.stageId = nil
        self.stageTypeT = nil
        self.stageTempT = nil
        self.stageTimeT = nil
    }
    
    var typeT: String {
        switch stage.type {
        case .mash:
            return "Mash"
        case .liquor:
            return "Liquor"
        case .boil:
            return "Boil"
        case .fermentation:
            return "Fermentation"
        case .wash:
            return "Wash"
        case .none:
            return ""
        }
    }
    
    //MARK:- Value in formatted text
    var tempT: String {
        let val = Float(stage.temp ?? 0) / 100
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let str = formatter.string(from: NSNumber(value: val)) ?? ""
        return "\(str)º C"
    }
    
    var timeT: String {
        
        if let time = stage.time {
            return "\(time) min"
        }
        return ""
    }
    
    //MARK:- Builder pattern function
    func recipe(id: Int) -> StageViewModel {
        self.stageRecipe = id
        return self
    }
    
    func type(type: Int) -> StageViewModel {
        self.stageTypeT = StageEnum(rawValue: type + 1)
        return self
    }
    
    func temp(temp: String) -> StageViewModel {
        let t = Int(temp)
        self.stageTempT = t
        return self
    }
    
    func time(time: String) -> StageViewModel {
        let t = Int(time)
        self.stageTimeT = t
        return self
    }
     
}
