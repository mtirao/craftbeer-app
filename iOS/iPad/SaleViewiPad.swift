//
//  SaleViewiPad.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 06/02/2023.
//

import SwiftUI

struct SaleViewiPad: View {
    
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

    @State var total: Float = 0.0
    
    var body: some View {
        HStack {
            JournalView()
            Rectangle()
                .frame(width: 1)
                .backgroundStyle(.black)
            
            KeyPadView(total: $total)
        }
    }
}

struct SaleViewiPad_Previews: PreviewProvider {
    static var previews: some View {
        SaleViewiPad()
    }
}
