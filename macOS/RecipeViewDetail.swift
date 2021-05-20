//
//  RecipeViewDetail.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI


struct RecipeViewDetail: View {
    
    @ObservedObject var recipe: RecipeViewModel
    
    @EnvironmentObject  var recipes : RecipeDataProvider  //= RecipeDataProvider()
    
    @State private var showingIngredientSheet = false
    @State private var showingStageSheet = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Recipe Name", text: self.$recipe.recipeName)
                    .font(.title)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                    .textFieldStyle(PlainTextFieldStyle())
                Spacer()
                
                Button(action: saveRecipe) {
                    Image(systemName: "square.and.arrow.down")
                }
                Button(action: deleteRecipe) {
                    Image(systemName: "trash")
                }
                
            }
            HStack {
                TextField("Recipe Style", text: self.$recipe.recipeStyle)
                    .font(.headline)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.gray)
                    .textFieldStyle(PlainTextFieldStyle())
                Spacer()
                
            }
            HStack {
                
                FieldView(text: "ABV", formatter: ABVFormatter(), fieldText: self.$recipe.recipeAbv)
                Spacer()
                FieldView(text: "IBU", formatter: IBUFormatter(), fieldText: self.$recipe.recipeIbu)
                Spacer()
                FieldView(text: "Color", formatter: ColorFormatter(), fieldText: self.$recipe.recipeColor)
                Spacer()
            }
            Divider()
            VStack {
                HStack {
                    Text("Ingredients")
                    Spacer()
                    Button(action: addIngredient) {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $showingIngredientSheet) {
                        IngredientSheet(isVisible: self.$showingIngredientSheet, recipe: self.recipe)
                            .environmentObject(self.recipes)
                    }
                }
                List(recipes.ingredientList) {item in
                    IngredientView(ingredient: item)
                   
                }
            }
            Divider()
            VStack {
                HStack {
                    Text("Stages")
                    Spacer()
                    Button(action: addStage) {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $showingStageSheet) {
                        StageSheet(isVisible: self.$showingStageSheet, recipe: self.recipe)
                            .environmentObject(self.recipes)
                    }
                }
                
                List(recipes.stageList) {item in
                    StageView(stage: item)
                }
            }
            
            Spacer()
        }.padding()
        .background(Color("color_grayscale_200"))
        .onAppear() {
            self.recipes.fetchAll(recipe: recipe.recipeId!)
        }
        .onReceive(self.recipes.updatedRecipe) {recipe in
            
            self.recipes.fetchAll()
        }
    }
    
    private func addStage() {
        self.showingStageSheet = true
    }
    
    private func addIngredient() {
        self.showingIngredientSheet = true
    }
    
    private func saveRecipe() {
        self.recipes.updateRecipe(recipe: self.recipe)
    }
    
    private func deleteRecipe() {
        self.recipes.delete(recipe: self.recipe)
    }
    
    init(recipe: RecipeViewModel) {
        self.recipe = recipe
        
    }
}

