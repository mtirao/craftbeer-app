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
                
                if recipe.recipeStatus == .ready || recipe.recipeStatus == .finished {
                    Image("hop")
                        .resizable()
                        .frame(width: 20, height: 20)
                }else {
                    Image("hop")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("processing_status"))
                }
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
            .padding([.bottom], 4)
            
            #if os(iOS) || os(macOS)
                HStack {
                    
                    VStack {
                        Text("ABV")
                            .font(.caption)
                        Text(ABVFormatter().string(for: recipe.recipeAbv) ?? "")
                            .font(.caption)
                    }
                    Spacer()
                    
                    VStack {
                        Text("IBU")
                            .font(.caption)
                        Text(IBUFormatter().string(for: recipe.recipeIbu) ?? "")
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Text("Color")
                            .font(.caption)
                        Text(ColorFormatter().string(for: recipe.recipeColor) ?? "")
                            .font(.caption)
                    }
                }
            #endif
        }
    }
}
