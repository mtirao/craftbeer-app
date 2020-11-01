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
                Text(recipe.name)
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                Spacer()
                
                
            }
            HStack {
                Text(recipe.style)
                    .font(.caption)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
                Spacer()
            }
            HStack {
                Text("ABV: \(recipe.abv)")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .truncationMode(.middle)
                Spacer()
                Text("IBU: \(recipe.ibu)")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .truncationMode(.middle)
                Spacer()
                Text("Color: \(recipe.color)")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .truncationMode(.middle)
            }
        }
    }
}
