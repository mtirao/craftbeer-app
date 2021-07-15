//
//  RecipeViewDetail.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI


struct RecipeViewDetail: View {
    
    
    @EnvironmentObject var recipes : RecipeDataProvider 
    
    
    @State private var showingIngredientSheet = false
    @State private var showingStageSheet = false
    
    @State private var recipeName : String
    @State private var recipeStyle : String
    @State private var recipeAbv : String
    @State private var recipeIbu : String
    @State private var recipeColor : String
    
    private let recipe: RecipeViewModel
    
    @StateObject var ingredientProvider = IngredientDataProvider()
    @StateObject var stageProvider = StageDataProvider()
    
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
                }.buttonStyle(BorderlessButtonStyle())
                
                Button(action: deleteRecipe) {
                    Image(systemName: "trash")
                }.buttonStyle(BorderlessButtonStyle())
                
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
            
            Section(header: sectionHeader(title: "Ingredients", action: addIngredient)) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(ingredientProvider.ingredientList, id: \.self) {item in
                            IngredientView(ingredient: item)
                                .padding([.top, .bottom, .leading, .trailing], 4)
                        }
                    }
                }
                
            }.frame(minHeight:40)
            
            
            Section(header: sectionHeader(title: "Stages", action: addStage)) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(stageProvider.stageList, id: \.self) {item in
                            StageView(stage: item)
                                .padding([.top, .bottom, .leading, .trailing], 4)
                        }
                    }
                }
                
            }.frame(minHeight:40)
            
            Spacer()
        }.padding()
        .background(Color.white)
        .onAppear{
            if let recipeId = recipe.recipeId {
                self.ingredientProvider.fetchAll(recipe: recipeId)
                self.stageProvider.fetchAll(recipe: recipeId)
            }
        }
    }
    
    @ViewBuilder func sectionHeader(title: String, action: @escaping () -> Void) -> some View {
        HStack {
            Text(title)
            Spacer()
            Button(action: action) {
                Image(systemName: "plus")
            }.foregroundColor(Color("wannaka_red"))
            .buttonStyle(BorderlessButtonStyle())
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

