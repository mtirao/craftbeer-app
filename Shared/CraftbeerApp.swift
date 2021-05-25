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
            #if os(iOS) || os(tvOS)
            ContentView()
                //.frame(width: 750, height: 500)
                .background(Color.white)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #else
                ContentView()
                    .frame(width: 1000, height: 700)
                    .background(Color.white)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #endif
        }
    }
}
