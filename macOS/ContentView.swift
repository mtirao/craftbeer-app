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

    @ObservedObject var recipes = RecipeDataProvider()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes.recipeList) { item in
                    NavigationLink(destination: RecipeViewDetail(recipe: item)) {
                        RecipeView(recipe: item)
                    }
                }.onDelete(perform: deleteItems)
                .onTapGesture {
                    
                }
               
            }.id(UUID())
           /* .navigationBarItems(leading:
                                    Button(action: addItem) {
                                        Label("", systemImage: "plus")
            })*/
            .navigationTitle("Craftbeer")
            
        }.toolbar {
            #if os(iOS)
            EditButton()
            #endif
            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
            
            Button(action: addItem) {
                Label("Save Image", systemImage: "square.and.arrow.down")
            }
        }.onAppear() {
            self.recipes.fetchAll()
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