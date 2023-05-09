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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.timestamp, ascending: true)],
        animation: .default)
    private var expenses: FetchedResults<Expense>
    
    private let dataProvider = ReportDataProvider()
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    List {
                        ForEach(dataProvider.monthly(transactions), id: \.self) {(sections: [Transaction]) in
                            Section(header:
                                        Text(dataProvider.sectionMonthlyHeader(transaction: sections))
                                .font(.headline)) {
                                    Text(dataProvider.computeTotalSales(transaction: sections))
                                }
                        }
                    }
                } label: {
                    Text("Monthly Sales")
                }
                
                NavigationLink {
                    List {
                        ForEach(dataProvider.monthlyExpense(expenses), id: \.self) {(sections: [Expense]) in
                            Section(header:
                                        Text(dataProvider.sectionMonthlyHeader(expense: sections))
                                .font(.headline)) {
                                    Text(dataProvider.computeTotalExpense(expense:sections))
                                }
                        }
                    }
                } label: {
                    Text("Monthly Expense")
                }
                
                NavigationLink {
                    List {
                        ForEach(dataProvider.tendersTrx(tenders), id: \.self) {(sections: [Tender]) in
                            Section(header:
                                        Text(dataProvider.sectionTenderHeader(tender: sections))
                                .font(.headline)) {
                                    Text(dataProvider.computeTotalTenders(tender: sections))
                                }
                        }
                    }
                } label: {
                    Text("Total by Tenders")
                }
                
                NavigationLink {
                    List {
                        ForEach(dataProvider.items(transactions), id: \.self) {(sections: [Transaction]) in
                            Section(header:
                                        Text(dataProvider.sectionItemsHeader(transaction: sections))
                                .font(.headline)) {
                                    Text(dataProvider.computeTotalSales(transaction: sections))
                                }
                        }
                    }
                } label: {
                    Text("Total by Category")
                }
                
                NavigationLink {
                    List {
                        ForEach(dataProvider.quantity(transactions), id: \.self) {(sections: [TransactionViewModel]) in
                            Section(header:
                                        Text(sections.first?.date ?? "")
                                .font(.headline)) {
                                    ForEach(sections, id: \.self) {transaction in
                                        HStack {
                                            Text("\(transaction.presentation)")
                                            Spacer()
                                            Text(dataProvider.convertToLiter(transaction: transaction))
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
    
    
}

struct ReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsView()
    }
}
