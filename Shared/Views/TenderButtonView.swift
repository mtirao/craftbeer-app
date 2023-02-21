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
            SalesView.trxUUID = UUID()
            dataProvider.getTransactionItems()
        }
        label: {
            Text(name).font(.title)
            
        }
        .frame(width: 129, height: 30)
        .padding()
        .background(Color(uiColor: Colors.itemBlue.uiColor))
        .foregroundColor(.white)
        
    }
}
