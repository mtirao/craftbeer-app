//
//  ExpenseDetailView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 12/09/2022.
//

import SwiftUI
 

struct ExpenseDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var name: String = ""
    @State private var type: String = "Growler"
    @State private var amount: Float = 0
    @State private var quantity: Float = 0
    
    private let presentations = ["Rent", "Service", "Beer", "Can", "Bottle", "Jar", "Package", "Container"]

    
    var item: Expense
    
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
                    Text("Quantity:")
                        .font(.headline)
                    Spacer()
                    TextField("Quantity", value: $quantity, formatter: NumberFormatter.quantityFormatter)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Amount:")
                        .font(.headline)
                    Spacer()
                    TextField("$0.00", value: $amount, formatter: NumberFormatter.priceFormatter)
                        .multilineTextAlignment(.trailing)
                }
                Picker("Type", selection: $type) {
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
            self.type = item.type ?? ""
            self.amount = item.amount
            self.quantity = item.quantity
        })
    }
    
    
    private func updateItem(item: Expense) {
        
        item.name = self.name
        item.type = self.type
        item.amount = Float(self.amount)
        item.quantity = self.quantity
        
        do {
            self.presentationMode.wrappedValue.dismiss()
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
