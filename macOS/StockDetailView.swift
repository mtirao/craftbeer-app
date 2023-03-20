//
//  StockDetailView.swift
//  Craftbeer (macOS)
//
//  Created by Marcos Tirao on 19/03/2023.
//

import SwiftUI

struct StockDetailView: View {
    
    var item: Item
    
    private let priceFormatter =  NumberFormatter.priceFormatter
    
    var body: some View {
        VStack {
            HStack {
                Text(item.name ?? "")
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(priceFormatter.string(from: NSNumber(floatLiteral: Double(item.price))) ?? "")
                    .multilineTextAlignment(.leading)
            }
        }
    }
}
