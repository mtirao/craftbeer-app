//
//  PDFTicketView.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 13/10/2022.
//

import SwiftUI

struct PDFTicketView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        predicate: NSPredicate(format: "number == %@", PDFTicketView.lastTrxUUID as CVarArg),
        animation: .default)
    private var saleItems: FetchedResults<Transaction>
    
    static var lastTrxUUID: UUID = UUID()
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            Button("Dismiss Modal") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct PDFTicketView_Previews: PreviewProvider {
    static var previews: some View {
        PDFTicketView()
    }
}
