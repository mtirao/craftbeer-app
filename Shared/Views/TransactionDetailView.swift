//
//  TransactionDetailView.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 24/10/2022.
//

import SwiftUI

struct TransactionDetailView: View {
    
    let transaction: [Transaction]
    
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        
        List {
            ForEach(transaction) { item in
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
                        Text(NSNumber(value:item.price), formatter: numberFormatter)
                            .font(.callout)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(transaction: [])
    }
}
