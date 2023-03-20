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
    
    @State private var isActive: Bool = false
    
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
                                VStack {
                                    HStack {
                                        Text(computeTotalSales(transaction: sections))
                                        Spacer()
                                    }
                                    HStack {
                                        Text(computeTotalPurchase(transaction: sections))
                                        Spacer()
                                    }
                                }
                            }
                        }
                }
            }
            .navigationTitle("Transactions")
#if os(iOS) || os(macOS)
            .background(Color.white)
#endif
        }
        
    }
    
    func monthly(_ result : FetchedResults<Transaction>) -> [[Transaction]] {
        let results = Dictionary(grouping: result){ (element : Transaction)  in
            dateMonthlyFormater(date: element.timestamp!)
        }.values.sorted() { $0[0].timestamp! > $1[0].timestamp! }
        
        return results
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
    
    func dateMonthlyFormater(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func sectionMonthlyHeader(transaction: [Transaction]) -> String {
        guard let date = transaction.first?.timestamp else {
            return ""
        }
        let dateTxt = self.dateMonthlyFormater(date: date)
        return "\(dateTxt)"
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
    
    func computeTotalPurchase(transaction: [Transaction]) -> String {
        let total = transaction.reduce(0) { $0 + $1.purchasePrice }
        let txt = numberFormatter.string(from: NSNumber(value: total)) ?? ""
        
        return "Costo Totales: \(txt)"
    }
    
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
