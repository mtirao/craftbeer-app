//
//  ContentView.swift
//  Shared
//
//  Created by Marcos Tirao on 23/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    private var currentRecipe = -1
    
    @State private var searchText = ""

    @State private var total: Float = 0
    
    @Environment(\.managedObjectContext) private var viewContext

    @State private var trxUUID = UUID()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    

    var body: some View {
        
        TabView {
            RecipesView()
                .tabItem{
                    Label("Recipes", systemImage: "list.dash")
                }
            
            StockView()
                .tabItem{
                    Label("Stock", systemImage: "cart")
                }
            
            
            SalesView(total: $total)
                .tabItem{
                    Label("Sales", systemImage: "bag")
                }
                .onAppear{
                    self.trxUUID = UUID()
                    self.total = 0
                }
            
            TransactionView()
                .tabItem{
                    Label("Transaction", systemImage: "creditcard.fill")
                }
        }
        
    }
    
    private mutating func selectCurrentRecipe(index: Int) {
        self.currentRecipe = index
    }
    
}


private let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

