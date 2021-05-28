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
            VStack {
                Text(ingredient.typeT)
                    .font(.footnote)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                Text(ingredient.nameT)
                    .font(.caption)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
            }
            HStack {
                Text("\(ingredient.valueT)")
                    .font(.caption)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
                Text("\(ingredient.unitT)")
                    .font(.caption)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
            }
        }.frame(width: 100, height: 90)
        .background(Color("color_grayscale_200"))
        .cornerRadius(16)
    }
}
