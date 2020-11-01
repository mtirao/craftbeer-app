//
//  RecipeViewDetail.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI

struct RecipeViewDetail: View {
    
    let recipe: RecipeViewModel
    
    @State private var recipeName = ""
    @State private var recipeStyle = ""
    @State private var recipeAbv = ""
    @State private var recipeColor = ""
    @State private var recipeIbu = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Recipe Name", text: $recipeName)
                    .font(.title)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                    .textFieldStyle(PlainTextFieldStyle())
                Spacer()
                
            }
            HStack {
                TextField("Recipe Style", text: $recipeStyle)
                    .font(.headline)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.gray)
                    .textFieldStyle(PlainTextFieldStyle())
                Spacer()
                
            }
            HStack {
                
                FieldView(text: "ABV", fieldText: $recipeAbv)
                Spacer()
                FieldView(text: "IBU", fieldText: $recipeIbu)
                Spacer()
                FieldView(text: "Color", fieldText: $recipeColor)
                Spacer()
            }
            Divider()
            Spacer()
        }.padding()
    }
    
    init(recipe: RecipeViewModel) {
        self.recipe = recipe
        self._recipeName = State(wrappedValue: recipe.name)
        self._recipeStyle = State(wrappedValue: recipe.style)
        self._recipeAbv = State(wrappedValue: recipe.abv)
        self._recipeColor = State(wrappedValue: recipe.color)
        self._recipeIbu = State(wrappedValue: recipe.ibu)
    }
}

