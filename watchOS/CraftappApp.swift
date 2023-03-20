//
//  CraftappApp.swift
//  Craftapp Watch App
//
//  Created by Marcos Tirao on 10/03/2023.
//

import SwiftUI

@main
struct Craftapp_Watch_AppApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
