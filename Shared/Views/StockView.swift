//
//  StockView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/08/2022.
//

import SwiftUI

struct StockView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        StockDetailView(item: item)
                    } label: {
                        Text("\(item.name!)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Stock")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
                #if os(iOS)
                ToolbarItem {
                    EditButton()
                }
                #endif
            }
        }//.navigationViewStyle(DefaultListStyle())
        
    }
    
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = "#Unnamed"
            newItem.presentation = "Growler"
            
            do {
                try viewContext.save()
            } catch {
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
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
    }
}
