//
//  Ingredient.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 01/11/2020.
//

import Foundation


struct Ingredient: Codable{
    
    let id: Int64?
    let recipe: Int64?
    let name: String?
    let type: String?
    let unit: Int?
    let amount: Int?
    let style: String?
  
}
