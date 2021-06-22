//
//  Recipe.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/10/2020.
//

import Foundation

enum RecipeStatusEnum: String, Codable {
    case ready = "ready"
    case finished = "finished"
    case processing = "processing"
}


struct Recipe: Codable{
    
    let id: Int?
    let name: String?
    let color: Int?
    let ibu: Int?
    let abv: Int?
    let style: String?
    let status: RecipeStatusEnum?
    
}


