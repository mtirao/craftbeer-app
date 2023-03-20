//
//  ContentView.swift
//  Craftbeer Watch App
//
//  Created by Marcos Tirao on 06/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        TabView {
            
            StockView()
                .tabItem{
                    Text("Stock")
                }
            
            TransactionView()
                .tabItem{
                    Text("Transactions")
                }
            
            ReportsView()
                .tabItem{
                    Text("Reports")
                }
        }.tabViewStyle(.automatic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
