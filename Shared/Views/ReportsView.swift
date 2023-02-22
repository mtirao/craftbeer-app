//
//  ReportsView.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 10/02/2023.
//

import SwiftUI

struct ReportsView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        animation: .default)
    private var transactions: FetchedResults<Transaction>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tender.timestamp, ascending: true)],
        animation: .default)
    private var tenders: FetchedResults<Tender>
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    List {
                        ForEach(monthly(transactions), id: \.self) {(sections: [Transaction]) in
                            Section(header:
                                        Text(sectionMonthlyHeader(transaction: sections))
                                .font(.headline)) {
                                    Text(computeTotalSales(transaction: sections))
                                }
                        }
                    }
                } label: {
                    Text("Monthly Sales")
                }
                
                NavigationLink {
                    List {
                        ForEach(tendersTrx(tenders), id: \.self) {(sections: [Tender]) in
                            Section(header:
                                        Text(sectionTenderHeader(tender: sections))
                                .font(.headline)) {
                                    Text(computeTotalTenders(tender: sections))
                                }
                        }
                    }
                } label: {
                    Text("Total by Tenders")
                }
                
                NavigationLink {
                    List {
                        ForEach(items(transactions), id: \.self) {(sections: [Transaction]) in
                            Section(header:
                                        Text(sectionItemsHeader(transaction: sections))
                                .font(.headline)) {
                                    Text(computeTotalSales(transaction: sections))
                                }
                        }
                    }
                } label: {
                    Text("Total by Items")
                }
                
                NavigationLink {
                    List {
                        ForEach(quantity(transactions), id: \.self) {(sections: [TransactionViewModel]) in
                            Section(header:
                                        Text(sections.first?.date ?? "")
                                .font(.headline)) {
                                    ForEach(sections, id: \.self) {transaction in
                                        HStack {
                                            Text("\(transaction.presentation)")
                                            Spacer()
                                            Text("\(transaction.quantity) /  \(transaction.quantity * 2)lts.")
                                        }
                                    }
                                }
                        }
                    }
                } label: {
                    Text("Total by Quantity")
                }
            }
            .navigationTitle("Reports")
        }
    }
    
    func convertToLiter(transaction: TransactionViewModel) -> String {
        if transaction.presentation == "Growler" {
            return "\(transaction.quantity) / \(transaction.quantity * 2)lts."
        }
        
        if transaction.presentation == "Pet" {
            return "\(transaction.quantity) / \(transaction.quantity)lts."
        }
        
        if transaction.presentation == "Pint" {
            return "\(transaction.quantity) / \(Double(transaction.quantity) * 0.473)lts."
        }
        
        return ""
    }
    
    func tendersTrx(_ result : FetchedResults<Tender>) -> [[Tender]] {
        let results = Dictionary(grouping: result){ (element : Tender)  in
            element.name
        }.values.sorted() { $0[0].timestamp! > $1[0].timestamp! }
        
        return results
    }
    
    func quantity(_ result : FetchedResults<Transaction>) -> [[TransactionViewModel]] {
        
        let results = Dictionary(grouping: result){ (element : Transaction)  in
            dateMonthlyFormater(date: element.timestamp!)
        }.values.sorted() { $0[0].timestamp! > $1[0].timestamp! }
        
        var filtered: [[TransactionViewModel]] = [[]]
        for monthly in results {
            var growler = TransactionViewModel(presentation: "Growler", name: "Growler", quantity: 0, date: dateMonthlyFormater(date: monthly.first?.timestamp ?? Date()))
            var pet = TransactionViewModel(presentation: "Pet", name: "Pint", quantity: 0, date: dateMonthlyFormater(date: monthly.first?.timestamp ?? Date()))
            var pint = TransactionViewModel(presentation: "Pint", name: "Pint", quantity: 0, date: dateMonthlyFormater(date: monthly.first?.timestamp ?? Date()))
            
            var transaction: [TransactionViewModel] = []
            for trx in monthly {
                if trx.presentation == "Growler" {
                    growler = TransactionViewModel(presentation: "Growler", name: "Growler", quantity: growler.quantity + 1, date: growler.date)
                }
                if trx.presentation == "Pint" {
                    pint = TransactionViewModel(presentation: "Pint", name: "Pint", quantity: pint.quantity + 1, date: growler.date)
                }
                if trx.presentation == "Pet" {
                    pet = TransactionViewModel(presentation: "Pet", name: "Pint", quantity: pet.quantity + 1, date: growler.date)
                }
            }
            
            if growler.quantity != 0 {
                transaction.append(growler)
            }
            
            if pet.quantity != 0 {
                transaction.append(pet)
            }
            
            if pint.quantity != 0 {
                transaction.append(pint)
            }
            
            if transaction.count != 0 {
                filtered.append(transaction)
            }
        }
        
        return filtered
    }
    
    func items(_ result : FetchedResults<Transaction>) -> [[Transaction]] {
        let results = Dictionary(grouping: result){ (element : Transaction)  in
            element.name
        }.values.sorted() { $0[0].timestamp! > $1[0].timestamp! }
        
        return results
    }
    
    func monthly(_ result : FetchedResults<Transaction>) -> [[Transaction]] {
        let results = Dictionary(grouping: result){ (element : Transaction)  in
            dateMonthlyFormater(date: element.timestamp!)
        }.values.sorted() { $0[0].timestamp! > $1[0].timestamp! }
        
        return results
    }
    
    func dateMonthlyFormater(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func sectionItemsHeader(transaction: [Transaction]) -> String {
        guard let name = transaction.first?.presentation else {
            return ""
        }
        return name
    }
    
    func sectionTenderHeader(tender: [Tender]) -> String {
        guard let name = tender.first?.name else {
            return ""
        }
        return name
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
        let dateTxt = DateFormatter.dateFormatter.string(from: date)
        return "\(dateTxt)"
    }
    
    func computeTotalSales(transaction: [Transaction]) -> String {
        let total = transaction.reduce(0) { $0 + $1.price }
        let txt = NumberFormatter.priceFormatter.string(from: NSNumber(value: total)) ?? ""
        
        return "Totals: \(txt)"
    }
    
    func computeTotalItems(transaction: Transaction) -> String {
        return "Totals: \(transaction.description)"
    }
    
    func computeTotalTenders(tender: [Tender]) -> String {
        let total = tender.reduce(0) { $0 + $1.amount}
        let txt = NumberFormatter.priceFormatter.string(from: NSNumber(value: total)) ?? ""
        
        return "Totals: \(txt)"
    }
    
    func computeTotalPurchase(transaction: [Transaction]) -> String {
        let total = transaction.reduce(0) { $0 + $1.purchasePrice }
        let txt = NumberFormatter.priceFormatter.string(from: NSNumber(value: total)) ?? ""
        
        return "Costo Totales: \(txt)"
    }
}

struct ReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsView()
    }
}
