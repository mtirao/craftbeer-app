//
//  Ingredient.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 01/11/2020.
//

import Foundation


enum UnitEnum: Int, Codable {
    case kilo = 1
    case grams = 2
    case liter = 3
}

enum TypeEnum: String, Codable {
    case malt = "malt"
    case yeast = "yeast"
    case water = "water"
    case hop = "hop"
}

struct Ingredient: Codable{
    
    let id: Int?
    let recipe: Int?
    let name: String?
    let type: TypeEnum?
    let unit: UnitEnum?
    let value: Int?
  
}
