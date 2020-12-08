//
//  ContentView.swift
//  Shared
//
//  Created by Marcos Tirao on 23/10/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    private var currentRecipe = -1
    
    @ObservedObject var recipes = RecipeDataProvider()
    
    var updateRecipe = RecipeDataProvider()
    
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
                                    RecipeViewDetail(recipe:detail).environmentObject(self.updateRecipe)) {
                                RecipeView(recipe: recipes.recipeList[index])
                            }
                        }.onDelete(perform: deleteItems)
                       
                    }.id(UUID())
                    .navigationTitle("Craftbeer")
                    .listStyle(SidebarListStyle())
                    HStack {
                        
                        Button(action: {
                            self.showingSheet = true
                        }){
                            Text("+")
                                .font(.title)
                        }.padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .buttonStyle(BorderlessButtonStyle())
                        .sheet(isPresented: $showingSheet) {
                            RecipeSheet(isVisible: self.$showingSheet)
                                .environmentObject(self.updateRecipe)
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
