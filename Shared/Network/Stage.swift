//
//  Stage.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 15/11/2020.
//

import Foundation

enum StageEnum: Int, Codable {
    case mash = 1
    case liquor = 2
    case boil = 3
    case fermentation = 4
    case wash = 5
}

struct Stage: Codable{
    
    let id: Int?
    let recipe: Int?
    let type: StageEnum?
    let temp: Int?
    let time: Int?
}

