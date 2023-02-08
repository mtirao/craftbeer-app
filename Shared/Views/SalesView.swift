//
//  SwiftUIView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/08/2022.
//

import SwiftUI

struct SalesView: View {
    
    static var trxUUID: UUID = UUID()
    
    @Binding var total: Float
    @State private var isPresented = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        predicate: NSPredicate(format: "number == %@", SalesView.trxUUID as CVarArg),
        animation: .default)
    private var saleItems: FetchedResults<Transaction>

    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    TicketView(total: $total)
                } label: {
#if os(macOS) || os(tvOS)
                    TextField("$0.00", value: $total, formatter: NumberFormatter.priceFormatter)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .font(.title)
                        .padding()
                        .multilineTextAlignment(.trailing)
                        .disabled(true)
#elseif os(iOS)
                    TextField("$0.00", value: $total, formatter: NumberFormatter.priceFormatter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .font(.title)
                        .padding()
                        .multilineTextAlignment(.trailing)
                        .disabled(true)
#endif
                }
                
                ScrollView {
                    ForEach(update(items), id: \.self) {(sections: [Item]) in
                        Section {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(sections) { item in
                                        ItemView(item: item)
#if os(macOS) || os(iOS)
                                        .onTapGesture{
                                            self.total += item.price
                                            saleItem(item: item)
                                        }
#endif
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
            }
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

struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView(total: .constant(0))
    }
}
