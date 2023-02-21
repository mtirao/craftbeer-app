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
    
    @StateObject private var transactionProvider: TransactionDataProvider = TransactionDataProvider()
    
    var body: some View {
        HStack {
            JournalView()
                .environmentObject(transactionProvider)
            Rectangle()
                .frame(width: 1)
                .backgroundStyle(.black)
            
            KeyPadView()
                .environmentObject(transactionProvider)
        }.onAppear {
            transactionProvider.viewContext = self.viewContext
        }
    }
    
    
}

struct SaleViewiPad_Previews: PreviewProvider {
    static var previews: some View {
        SaleViewiPad()
    }
}
