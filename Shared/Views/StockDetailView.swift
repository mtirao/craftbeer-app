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
    @State private var presentation: String = "Growler"
    @State private var price: Float = 0
    
    private let presentations = ["Growler", "Pet", "Pint", "Can", "Bottle", "Bag", "Jar"]
    
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
                 Picker("Presentation", selection: $presentation) {
                    ForEach(presentations, id: \.self) {
                        Text($0)
                            .id($0)
                    }
                 }.pickerStyle(.menu)
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
