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
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    @State private var showDetail = false
    @State private var name: String = ""
    @State private var presentation: String = ""
    @State private var price: Float = 0
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Form {
                            Section(header: Text("Item")) {
                                TextField("Name", text: $name)
                                TextField("Presentation", text: $presentation)
                                TextField("$0.00", value: $price, formatter: numberFormatter)
                            }
                        }.toolbar{
                            ToolbarItem(placement: .automatic ) {
                                Button(action: {
                                    updateItem(item: item)
                                }) {
                                   Text("Save")
                                }
                            }
                        }
                        .onAppear(perform: {
                            self.name = item.name ?? ""
                            self.presentation = item.presentation ?? ""
                            self.price = item.price
                        })
                    } label: {
                        Text("\(item.name!)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
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
            Text("Select an item")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func updateItem(item: Item) {
        
        item.name = self.name
        item.presentation = self.presentation
        item.price = Float(self.price)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = "Unnamed"

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
