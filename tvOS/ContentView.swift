//
//  ContentView.swift
//  Shared
//
//  Created by Marcos Tirao on 23/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    private var currentRecipe = -1
    
    @StateObject var recipes = RecipeDataProvider()
    
    @State private var searchText = ""
    @State private var showingSheet = false
    
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    List {
                        ForEach(recipes.recipeList.indices) { index in
                            let detail = recipes.recipeList[index]
                            NavigationLink(
                                destination:
                                    RecipeViewDetail(recipe:detail).environmentObject(recipes)) {
                                RecipeView(recipe: recipes.recipeList[index])
                                    .frame(height:80)
                            }
                        }
                       
                    }.id(UUID())
                    .navigationTitle("Craftbeer")
                    
                    HStack {
                        
                        Button(action: {
                            self.showingSheet = true
                        }){
                            Text("+")
                                .font(.title)
                        }.padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .sheet(isPresented: $showingSheet) {
                            RecipeSheet(isVisible: self.$showingSheet)
                                .environmentObject(self.recipes)
                                .frame(width: 200, height: 190)
                        }
                        
                        TextField("Search...", text: self.$searchText).padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    }
                }
                
            }.onAppear() {
                self.recipes.fetchAll()
            }
            
        }
        
    }

    private mutating func selectCurrentRecipe(index: Int) {
        self.currentRecipe = index
    }
    
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
