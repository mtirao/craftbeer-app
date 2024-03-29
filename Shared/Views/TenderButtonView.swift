//
//  TenderButtonView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 21/02/2023.
//

import SwiftUI

struct TenderButtonView: View {
    
    @EnvironmentObject var dataProvider: TransactionDataProvider
    
    let name: String
    
    var body: some View {
        Button{
            dataProvider.commitTransaction(name: name)
            dataProvider.getTransactionItems()
        }
        label: {
            Text(name).font(.title)
            
        }
        .frame(height: 30)
        .padding()
        #if !os(macOS)
        .background(Color(uiColor: Colors.itemBlue.uiColor))
        #endif
        .foregroundColor(.white)
    }
}
