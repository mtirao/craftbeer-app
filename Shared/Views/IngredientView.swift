//
//  RecipeView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI

struct IngredientView: View {
    
    let ingredient: IngredientViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(ingredient.typeT)
                    .font(.headline)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                Text(ingredient.nameT)
                    .font(.headline)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                Spacer()
                
                
            }
            HStack {
                Text("\(ingredient.valueT)")
                    .font(.subheadline)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
                Text("\(ingredient.unitT)")
                    .font(.subheadline)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
                Spacer()
            }
            
            Divider()
        }
    }
}
