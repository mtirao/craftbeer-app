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
                    NavigationLink(isActive: $showDetail) {
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
                                    Label("Save Item", systemImage: "square.and.arrow.down")
                                }
                            }
                        }
                    } label: {
                        Text("\(item.name!)")
                    }.onAppear(perform: {
                        self.name = item.name ?? ""
                        self.presentation = item.presentation ?? ""
                    })
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                
                #if os(iOS)
                ToolbarItem(placement: .automatic) {
                    EditButton()
                }
                #endif
                
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
    
    private func updateItem(item: Item) {
        
        item.name = self.name
        item.presentation = self.presentation
        item.price = Float(self.price)
        
        do {
            try viewContext.save()
            self.showDetail = false
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
