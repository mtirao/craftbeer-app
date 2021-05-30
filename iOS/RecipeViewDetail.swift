//
//  RecipeViewDetail.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI


struct RecipeViewDetail: View {
    
    private let recipe: RecipeViewModel
    
    @EnvironmentObject var recipes : RecipeDataProvider //= RecipeDataProvider()
    
    
    @State private var showingIngredientSheet = false
    @State private var showingStageSheet = false
    
    @State private var recipeName : String
    @State private var recipeStyle : String
    @State private var recipeAbv : String
    @State private var recipeIbu : String
    @State private var recipeColor : String
    

    @StateObject var ingredientProvider = IngredientDataProvider()
    @StateObject var stageProvider = StageDataProvider()
    
    
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
            
            
            Section(header: sectionHeader(title: "Ingredients", action: addIngredient)) {
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
                            buttons: [ .default(Text("Malt")),
                                       .default(Text("Hop")),
                                       .default(Text("Yeast")),
                                       .default(Text("Malt")),
                                       .cancel(Text("Cancel"))]
                        )
                    }
                }
                
            }.frame(minHeight:40)
            
            
            Section(header: sectionHeader(title: "Stages", action: addStage)) {
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
                            buttons: [ .default(Text("Mash")),
                                       .default(Text("Liquor")),
                                       .default(Text("Boil")),
                                       .default(Text("Fermetation")),
                                       .default(Text("Wash")),
                                       .cancel(Text("Cancel"))]
                        )
                    }
                }
                
            }.frame(minHeight:40)
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
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

