//
//  RecipeViewDetail.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI


struct RecipeViewDetail: View {
    
    
    @EnvironmentObject var recipes : RecipeDataProvider //= RecipeDataProvider()
    
    
    @State private var showingIngredientSheet = false
    @State private var showingStageSheet = false
    
    @State private var recipeName : String
    @State private var recipeStyle : String
    @State private var recipeAbv : String
    @State private var recipeIbu : String
    @State private var recipeColor : String
    
    private let recipe: RecipeViewModel

    private let recipeProvider : RecipeDataProvider = RecipeDataProvider()
    
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
                
                Button(action: saveRecipe) {
                    Image(systemName: "square.and.arrow.down")
                }
                Button(action: deleteRecipe) {
                    Image(systemName: "trash")
                }
                
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
                
                FieldView(text: "ABV", formatter: ABVFormatter(), fieldText: $recipeAbv)
                Spacer()
                FieldView(text: "IBU", formatter: IBUFormatter(), fieldText: $recipeIbu)
                Spacer()
                FieldView(text: "Color", formatter: ColorFormatter(), fieldText: $recipeColor)
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
                List(recipeProvider.ingredientList) {item in
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
                
                List(recipeProvider.stageList) {item in
                    StageView(stage: item)
                }
            }
            
            Spacer()
        }.padding()
        .background(Color("color_grayscale_200"))
        .onAppear() {
            self.recipeProvider.fetchAll(recipe: recipe.recipeId!)
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
        
        let aux = RecipeViewModel(recipeId: self.recipe.recipeId)
            .abv(recipe: self.recipeAbv)
            .color(recipe: self.recipeColor)
            .ibu(recipe: self.recipeIbu)
            .name(recipe: self.recipeName)
            .style(recipe: self.recipeStyle)
        
        self.recipes.updateRecipe(recipe: aux)
    }
    
    private func deleteRecipe() {
        self.recipes.delete(recipe: self.recipe)
    }
    
    init(recipe: RecipeViewModel) {
        self.recipe = recipe
        self.recipeName = recipe.recipeName
        self.recipeStyle = recipe.recipeStyle
        self.recipeAbv = recipe.recipeAbv
        self.recipeIbu = recipe.recipeIbu
        self.recipeColor = recipe.recipeColor
    }
   
}

