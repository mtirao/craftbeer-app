//
//  RecipeViewDetail.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI

struct RecipeViewDetail: View {
    
    private let recipe: RecipeViewModel
    
    @State private var showingAddIngredientSheet = false
    @State private var showingAddStageSheet = false
    
    @State private var showingIngredientSheet = false
    @State private var showingStageSheet = false
    
    @State private var recipeName : String
    @State private var recipeStyle : String
    @State private var recipeAbv : String
    @State private var recipeIbu : String
    @State private var recipeColor : String
    
    @State private var ingredientType = ""
    @State private var unitType = 0
    
    @State private var stageType: Int = 0
    
    
    
    @StateObject var ingredientProvider = IngredientDataProvider()
    @StateObject var stageProvider = StageDataProvider()
    @StateObject var recipes : RecipeDataProvider = RecipeDataProvider()
    
    var body: some View {
        List {
            Section(header: Text("Recipe")) {
                TextField("Recipe Name", text: $recipeName)
                    .font(.title)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                    .textFieldStyle(PlainTextFieldStyle())
                
                VStack {
                    HStack {
                        Text("Style")
                        Spacer()
                    }
                    TextField("Recipe Style", text: $recipeStyle)
                        .font(.headline)
                        .truncationMode(.tail)
                        .frame(minWidth: 20.0)
                        .foregroundColor(Color.gray)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                
                FieldView(text: "ABV", formatter: ABVFormatter(), fieldText: $recipeAbv)
                
                FieldView(text: "IBU", formatter: IBUFormatter(), fieldText: $recipeIbu)
                
                FieldView(text: "Color", formatter: ColorFormatter(), fieldText: $recipeColor)
            }
            
            
            Section(header: sectionHeader(title: "Ingredients", action: showAddIngredient)) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(self.ingredientProvider.ingredientList, id: \.self) {item in
                            IngredientView(ingredient: item)
                                .padding([.top, .bottom, .leading, .trailing], 4)
                        }
                    }.actionSheet(isPresented: $showingIngredientSheet) {
                        ActionSheet(
                            title: Text("Ingredients"),
                            message: Text("Select ingredients type"),
                            buttons: [ .default(Text("Malt")){self.addIngredient(type: "malt")},
                                       .default(Text("Hop")){self.addIngredient(type: "hop")},
                                       .default(Text("Yeast")){self.addIngredient(type: "yeast")},
                                       .default(Text("Water")){self.addIngredient(type: "Water")},
                                       .cancel(Text("Cancel"))]
                        )
                    }.sheet(isPresented: self.$showingAddIngredientSheet) {
                        
                        if let recipeId = self.recipe.recipeId, let unitType = UnitEnum(rawValue: self.unitType), let type = TypeEnum(rawValue: ingredientType)  {
                            
                            IngredientSheet(isVisible: self.$showingAddIngredientSheet,
                                             recipeId: recipeId,
                                             unitType: unitType,
                                             type: type)
                                .environmentObject(ingredientProvider)
                        }
                    }
                }
                
            }.frame(minHeight:40)
            
            
            Section(header: sectionHeader(title: "Stages", action: showAddStage)) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(self.stageProvider.stageList, id: \.self) {item in
                            StageView(stage: item)
                                .padding([.top, .bottom, .leading, .trailing], 4)
                        }
                    }.actionSheet(isPresented: $showingStageSheet) {
                        ActionSheet(
                            title: Text("Stages"),
                            message: Text("Select stages"),
                            buttons: [ .default(Text("Mash")){self.addStage(stage: 1)},
                                       .default(Text("Liquor")){self.addStage(stage: 2)},
                                       .default(Text("Boil")){self.addStage(stage: 3)},
                                       .default(Text("Fermentation")){self.addStage(stage: 4)},
                                       .default(Text("Wash")){self.addStage(stage: 5)},
                                       .cancel(Text("Cancel"))]
                        )
                    }.sheet(isPresented: self.$showingAddStageSheet) {
                        
                        if let recipeId = self.recipe.recipeId, let stageType = StageEnum(rawValue: self.stageType)  {
                            StageSheet(isVisible: self.$showingAddStageSheet,
                                   recipeId: recipeId,
                                   stageType: stageType)
                                .environmentObject(self.recipes)
                                .frame(height:300)
                        }
                    }
                }
                
            }.frame(minHeight:40)
            
            
        }.navigationBarTitleDisplayMode(.inline)
        .toolbar{
            HStack {
                Button(action: saveRecipe) {
                    Image(systemName: "square.and.arrow.down")
                }
                Button(action: deleteRecipe) {
                    Image(systemName: "trash")
                }
            }
        }.onAppear{
            if let recipeId = recipe.recipeId {
                self.ingredientProvider.fetchAll(recipe: recipeId)
                self.stageProvider.fetchAll(recipe: recipeId)
            }
        }
        .onReceive(self.recipes.updatedRecipe) {recipe in
            
            self.recipes.fetchAll()
        }.accentColor(Color("wannaka_red"))
    }
    
    
    @ViewBuilder func sectionHeader(title: String, action: @escaping () -> Void) -> some View {
        HStack {
            Text(title)
            Spacer()
            Button(action: action) {
                Image(systemName: "plus")
            }.foregroundColor(Color("wannaka_red"))
        }
    }
    
    private func addStage(stage: Int) {
        self.showingStageSheet = false
        
        self.stageType = stage
    
        self.showingAddStageSheet = true
    }
    
    private func addIngredient(type: String) {
        self.showingIngredientSheet = false
        
        self.ingredientType = type
        
        switch(type) {
        case "malt":
            self.unitType = 1
            break;
        case "hop":
            self.unitType = 1
            break;
        case "yeast":
            self.unitType = 2
            break;
        case "water":
            self.unitType = 3
            break;
        default:
            self.unitType = 1
            break;
        }
        
       // self.stageType = stage
    
        self.showingAddIngredientSheet = true
    }
    
    private func showAddStage() {
        self.showingStageSheet = true
    }
    
    private func showAddIngredient() {
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

