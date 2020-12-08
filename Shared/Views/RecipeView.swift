//
//  RecipeView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI

struct RecipeView: View {
    
    let recipe: RecipeViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(recipe.recipeName)
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                Spacer()
                
                
            }
            HStack {
                Text(recipe.recipeStyle)
                    .font(.caption)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
    }
}
