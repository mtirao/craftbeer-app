//
//  CraftbeerApp.swift
//  Shared
//
//  Created by Marcos Tirao on 23/10/2020.
//

import SwiftUI

@main
struct CraftbeerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        Window("Main", id: "main") {
            RecipesView()
                .frame(width: 1000, height: 500)
                .background(Color.white)
        }
        .commands{
            CraftbeerCommands()
        }
        
        Window("Stock List", id: "stock-list") {
            StockView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        Window("Reports", id: "reports") {
            ReportsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        Window("Sales", id: "sales") {
            SaleViewiPad()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
