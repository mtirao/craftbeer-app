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
                ForEach(update(transaction), id: \.self) {(sections: [Transaction]) in
                    Section(header:
                                Text(sectionHeader(transaction: sections))
                        .font(.headline)) {
                            NavigationLink {
                                TransactionDetailView(transaction: sections)
                            } label: {
                                Text(computeTotalSales(transaction: sections))
                            }
                    }
                }
            }.background(Color.white)
            .navigationTitle("Transactions")
        }
        
    }
    
    func update(_ result : FetchedResults<Transaction>)-> [[Transaction]]{
        
        let results = Dictionary(grouping: result){ (element : Transaction)  in
            dateFormater(date: element.timestamp!)
        }.values.sorted() { $0[0].timestamp! > $1[0].timestamp! }
        
        return results
    }
    
    func dateFormater(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func sectionHeader(transaction: [Transaction]) -> String {
        guard let date = transaction.first?.timestamp else {
            return ""
        }        
        let dateTxt = self.dateFormater(date: date)
        return "\(dateTxt)"
    }
    
    func computeTotalSales(transaction: [Transaction]) -> String {
        let total = transaction.reduce(0) { $0 + $1.price }
        let txt = numberFormatter.string(from: NSNumber(value: total)) ?? ""
        
        return "Ventas Totales: \(txt)"
    }
    
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
