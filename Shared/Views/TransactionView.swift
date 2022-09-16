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
                    Section(header: Text(sectionHeader(transaction: sections))) {
                        ForEach(sections) { item in
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
                }
            }
            .navigationTitle("Transactions")
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
    
    
    func update(_ result : FetchedResults<Transaction>)-> [[Transaction]]{
        
        let results = Dictionary(grouping: result){ (element : Transaction)  in
            dateFormater(date: element.timestamp!)
        }.values.sorted() { $0[0].timestamp! < $1[0].timestamp! }
        
        return results
    }
    
    func dateFormater(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func sectionHeader(transaction: [Transaction]) -> String {
        let date = self.dateFormater(date: transaction[0].timestamp!)
        let total = transaction.reduce(0) { $0 + $1.price }
        let totalTxt = numberFormatter.string(from: NSNumber(value: total)) ?? ""
        
        return "\(date) Total: \(totalTxt)"
    }
    
    
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
