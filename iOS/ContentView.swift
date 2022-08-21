//
//  ContentView.swift
//  Shared
//
//  Created by Marcos Tirao on 23/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    private var currentRecipe = -1
    
    @State private var selection: String? = nil
    
    @StateObject var recipes = RecipeDataProvider()
    
    @State private var searchText = ""
    @State private var showingSheet = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        
        TabView {
            recipesView()
                .tabItem{
                    Label("Recipes", systemImage: "list.dash")
                }
            stockView()
                .tabItem{
                    Label("Stock", systemImage: "cart")
                }
            
            salesView()
                .tabItem{
                    Label("Sales", systemImage: "bag")
                }
        }
        
    }
    
    
    @ViewBuilder private func salesView() -> some View {
        VStack {
            Text("Test")
        }
    }
 
    
    @ViewBuilder private func stockView() -> some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
    
    @ViewBuilder private func recipesView() -> some View {
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
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private mutating func selectCurrentRecipe(index: Int) {
        self.currentRecipe = index
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
