//
//  ContentView.swift
//  Shared
//
//  Created by Marcos Tirao on 23/10/2020.
//

import SwiftUI
import PopupView

struct ContentView: View {
    
    private var currentRecipe = -1
    
    @ObservedObject var recipes = RecipeDataProvider()
    
    @State private var searchText = ""
    @State private var showingSheet = false
    
    
    var body: some View {
        VStack {
            NavigationView {
                
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
                .sheet(isPresented: $showingSheet){
                    RecipeSheet(isVisible: self.$showingSheet)
                        .environmentObject(self.recipes)
                }
                .toolbar{
                    Button(action: {
                        self.showingSheet = true
                    }){
                        Label("New Recipe", systemImage: "plus")
                    }.padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .buttonStyle(BorderlessButtonStyle())
                }
                .listStyle(PlainListStyle())
    
            }.onAppear() {
                self.recipes.fetchAll()
            }
        }.accentColor(Color("wannaka_red"))
        
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
