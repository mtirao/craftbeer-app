//
//  TableButtonView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 21/02/2023.
//

import SwiftUI

struct TableButtonView: View {
    
    let number: Int
    
    @EnvironmentObject var dataProvider: TransactionDataProvider
    
    let name: String
    
    var body: some View {
        Button{
            dataProvider.switchTable(table: number)
            dataProvider.getTransactionItems()
        }
        label: {
            Text(name).font(.title)
            
        }
        .frame(height: 20)
        .padding()
        #if !os(macOS)
        .background(Color(uiColor: Colors.itemBlue.uiColor))
        #endif
        .foregroundColor(.white)
    }
}
