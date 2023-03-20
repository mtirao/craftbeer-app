//
//  CraftbeerCommands.swift
//  Craftbeer (macOS)
//
//  Created by Marcos Tirao on 19/03/2023.
//

import SwiftUI

struct CraftbeerCommands: Commands {

    @Environment(\.openWindow) var openWindow
    
    var body: some Commands {
        SidebarCommands()
        
        CommandMenu("Store") {
            Button("Stock...") {
                openWindow(id: "stock-list")
            }
            .disabled(false)
            
            Button("Reports...") {
                openWindow(id: "reports")
            }
            .disabled(false)
            Button("Sales...") {
                openWindow(id: "sales")
            }
            .disabled(false)
        }
    }
}

