//
//  Stage.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 15/11/2020.
//

import Foundation

enum StageEnum: Int, Codable {
    case liquor = 1
    case mash = 2
    case wash = 3
    case boil = 4
    case fermentation = 5
}

struct Stage: Codable{
    
    let id: Int?
    let recipe: Int?
    let type: StageEnum?
    let temp: Int?
    let time: Int?
}

