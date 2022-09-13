//
//  StockDetailView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 12/09/2022.
//

import SwiftUI
 

struct StockDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var name: String = ""
    @State private var presentation: String = ""
    @State private var price: Float = 0
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var item: Item
    
    var body: some View {
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
        }.onAppear(perform: {
            self.name = item.name ?? ""
            self.presentation = item.presentation ?? ""
            self.price = item.price
        })
    }
    
    
    private func updateItem(item: Item) {
        
        item.name = self.name
        item.presentation = self.presentation
        item.price = Float(self.price)
        
        do {
            self.presentationMode.wrappedValue.dismiss()
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
