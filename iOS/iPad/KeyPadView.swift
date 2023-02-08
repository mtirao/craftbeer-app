//
//  KeyPadView.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 06/02/2023.
//

import SwiftUI

struct KeyPadView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @Binding var total: Float
    
    var body: some View {
        
        VStack {
            TextField("$0.00", value: $total, formatter: NumberFormatter.priceFormatter)
                .textFieldStyle(DefaultTextFieldStyle())
                .font(.title)
                .padding()
                .multilineTextAlignment(.trailing)
                .disabled(true)
            Spacer()
            
            ScrollView {
                ForEach(update(items), id: \.self) {(sections: [Item]) in
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(sections) { item in
                                    ItemView(item: item)                                    .onTapGesture{
                                            self.total += item.price
                                            saleItem(item: item)
                                        }
                                }
                            }
                        }
                        Divider()
                    } header: {
                        HStack {
                            Text(sections.first?.presentation ?? "")
                                .font(.headline)
                            Spacer()
                        }
                    }
                }
            }.padding()
            
            HStack {
                
                Button{
                    self.total = 0.0
                    SalesView.trxUUID = UUID()
                }
                label: {
                    Text("PAGAR").font(.title)
                    
                }
                .frame(width: 520, height: 80)
                .padding()
                .background(Color(uiColor: Colors.itemBlue.uiColor))
                .foregroundColor(.white)
            }.padding()
        }
    }
    
    func update(_ result : FetchedResults<Item>)-> [[Item]]{
        
        let results = Dictionary(grouping: result){ (element : Item)  in
            element.presentation
        }.values.sorted() { ($0.first?.presentation ?? "") < ($1.first?.presentation ?? "") }
        
        return results
    }
    
    private func saleItem(item: Item) {
        
        let newItem = Transaction(context: viewContext)
        newItem.timestamp = Date()
        newItem.name = item.name
        newItem.price = item.price
        newItem.purchasePrice = item.purchasePrice
        newItem.itemDescription = item.itemDescription
        
        newItem.number = SalesView.trxUUID
        newItem.presentation = item.presentation
        newItem.quantity = 1

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct KeyPadView_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadView(total: .constant(0.0))
    }
}
