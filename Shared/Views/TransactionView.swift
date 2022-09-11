//
//  TransactionView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/08/2022.
//

import SwiftUI

struct TransactionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        animation: .default)
    private var transaction: FetchedResults<Transaction>
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(transaction) { item in
                    VStack{
                        Text(item.name ?? "")
                            .font(.headline)
                        Text(item.presentation ?? "")
                            .font(.callout)
                        Text(NSNumber(value:item.price), formatter: numberFormatter)
                            .font(.callout)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                
                #if os(iOS)
                ToolbarItem(placement: .automatic) {
                    EditButton()
                }
                #endif
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { transaction[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
