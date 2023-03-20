//
//  CraftbeerApp.swift
//  Craftbeer Watch App
//
//  Created by Marcos Tirao on 06/03/2023.
//

import SwiftUI

@main
struct Craftbeer_Watch_AppApp: App {
    
    let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
