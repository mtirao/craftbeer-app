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
    @State private var itemDescription: String = ""
    @State private var presentation: String = "Growler"
    @State private var price: Float = 0
    @State private var purchasePrice: Float = 0
    
    private let presentations = ["Clothes", "Package", "Growler", "Pet", "Pint", "Can", "Bottle", "Bag", "Jar", "Container"]

    
    var item: Item
    
    var body: some View {
        Form {
            Section(header: Text("Item")) {
                HStack {
                    Text("Name:")
                        .font(.headline)
                    Spacer()
                    TextField("Name", text: $name)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Description:")
                        .font(.headline)
                    Spacer()
                    TextField("Description", text: $itemDescription)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Purchase Price:")
                        .font(.headline)
                    Spacer()
                    TextField("$0.00", value: $purchasePrice, formatter: NumberFormatter.priceFormatter)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Sell Price:")
                        .font(.headline)
                    Spacer()
                    TextField("$0.00", value: $price, formatter: NumberFormatter.priceFormatter)
                        .multilineTextAlignment(.trailing)
                }
                Picker("Presentation", selection: $presentation) {
                    ForEach(presentations, id: \.self) {
                        Text($0)
                            .id($0)
                    }
                 }
                #if os(iOS) || os(macOS)
                .pickerStyle(.menu)
                #endif
                
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
            self.purchasePrice = item.purchasePrice
        })
    }
    
    
    private func updateItem(item: Item) {
        
        item.name = self.name
        item.presentation = self.presentation
        item.price = Float(self.price)
        item.purchasePrice = Float(self.purchasePrice)
        item.itemDescription = self.itemDescription
        
        do {
            self.presentationMode.wrappedValue.dismiss()
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
