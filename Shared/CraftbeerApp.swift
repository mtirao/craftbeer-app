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
        WindowGroup {
            ContentView()
                .background(Color.white)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
