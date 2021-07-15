//
//  RecipeViewDetail.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI

struct RecipeViewDetail: View {
    
    let recipe: RecipeViewModel
    
    
    @ObservedObject var recipes = RecipeDataProvider()
    
    var body: some View {
        VStack {
            HStack {
                Text(self.recipe.name)
                    .font(.title)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                    .textFieldStyle(PlainTextFieldStyle())
                Spacer()
                
            }
            HStack {
                Text(self.recipe.style)
                    .font(.headline)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.gray)
                    .textFieldStyle(PlainTextFieldStyle())
                Spacer()
                
            }
            HStack {
                
                Text("ABV: \(self.recipe.abv)")
                    .font(.headline)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.gray)
                    .textFieldStyle(PlainTextFieldStyle())
                Spacer()
                Text("IBU: \(self.recipe.ibu)")
                    .font(.headline)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.gray)
                    .textFieldStyle(PlainTextFieldStyle())
                Spacer()
                Text("Color: \(self.recipe.color)")
                    .font(.headline)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.gray)
                    .textFieldStyle(PlainTextFieldStyle())
                Spacer()
            }
            Divider()
            VStack {
                HStack {
                    Text("Ingredients")
                        .font(.headline)
                        .truncationMode(.tail)
                        .frame(minWidth: 20.0)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                List(recipes.ingredientList) {item in
                    IngredientView(ingredient: item)
                   
                }
            }
            Divider()
            VStack {
                HStack {
                    Text("Stages")
                        .font(.headline)
                        .truncationMode(.tail)
                        .frame(minWidth: 20.0)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                List(recipes.ingredientList) {item in
                    IngredientView(ingredient: item)
                   
                }
            }
            
            Spacer()
        }.padding()
    }
    
    private func addStage() {
        
    }
    
    private func addIngredient() {
        
    }
    
    private func saveRecipe() {
        
    }
    
    init(recipe: RecipeViewModel) {
        self.recipe = recipe
        
        self.recipes.fetchAll(recipe: recipe.recipeId)
    }
}

