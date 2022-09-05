//
//  RecipesView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/08/2022.
//

import SwiftUI

struct RecipesView: View {
    
    @StateObject var recipes = RecipeDataProvider()
    
    @State private var selection: String? = nil
    
    var body: some View {
        VStack {
            NavigationView {
                
                List {
                    ForEach(recipes.recipeList.indices) { index in
                        let detail = recipes.recipeList[index]
                        NavigationLink(
                            destination:
                                RecipeViewDetail(recipe:detail),
                            tag:"\(index)",
                            selection: $selection) {
                            RecipeView(recipe: recipes.recipeList[index])
                                .frame(height:80)
                        }

                    }
                   
                }.id(UUID())
                .navigationTitle("Craftbeer")
                .toolbar{
                    ToolbarItem {
                        Button(action: {
                            self.recipes.addRecipe()
                        }){
                            Label("New Recipe", systemImage: "plus")
                        }
                    }
                }
                .listStyle(PlainListStyle())
    
                
            }.onAppear() {
                self.recipes.fetchAll()
            }.navigationViewStyle(.automatic)
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
