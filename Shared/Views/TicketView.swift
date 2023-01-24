//
//  TicketView.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 13/10/2022.
//

import SwiftUI

struct TicketView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var total: Float
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        predicate: NSPredicate(format: "number == %@", SalesView.trxUUID as CVarArg),
        animation: .default)
    private var saleItems: FetchedResults<Transaction>
    
    var body: some View {
        
        List {
            Section(content: {
                ForEach(saleItems){item in
                    
                    VStack {
                        HStack {
                            Text(item.name ?? "")
                            Spacer()
                        }
                        HStack {
                            Text(item.presentation ?? "")
                            Spacer()
                        }
                        HStack {
                            Text(NSNumber(value:item.price), formatter: NumberFormatter.priceFormatter)
                                .font(.callout)
                            Spacer()
                        }
                    }
                }.onDelete(perform: deleteItems)
            }, header: {
                Text(computeTotalSales(transaction: saleItems))
            })
        }
        .toolbar {
            #if os(iOS)
            ToolbarItem {
                EditButton()
            }
            #endif
        }.onAppear{
            total = 0
        }.onDisappear {
            SalesView.trxUUID = UUID()
        }
    }
    
    func computeTotalSales(transaction: FetchedResults<Transaction>) -> String {
        let total = transaction.reduce(0) { $0 + $1.price }
        let txt = NumberFormatter.priceFormatter.string(from: NSNumber(value: total)) ?? ""
        
        return "Ventas Totales: \(txt)"
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { saleItems[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(total: .constant(0))
    }
}
