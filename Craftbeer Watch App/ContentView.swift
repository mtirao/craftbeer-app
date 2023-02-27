//
//  ContentView.swift
//  Craftbeer Watch App
//
//  Created by Marcos Tirao on 26/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            StockView()
                .tabItem{
                    Text("Stock")
                }
            
            ReportsView()
                .tabItem{
                    Text("Reports")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
