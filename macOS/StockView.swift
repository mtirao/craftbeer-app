//
//  StockView.swift
//  Craftbeer (macOS)
//
//  Created by Marcos Tirao on 19/03/2023.
//

import SwiftUI
import AppKit

struct StockView: View {
   
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        List {
            ForEach(items) { item in
                StockDetailView(item: item)
            }
        }
        .toolbar{
            ToolbarItem {
                Button(action: {
                    self.saveToFile()
                }){
                    Label("Print", systemImage: "square.and.arrow.down")
                }
            }
        }
    }
    
    private func saveToFile() {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.text]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.allowsOtherFileTypes = false
        savePanel.title = "Save your text"
        savePanel.message = "Choose a folder and a name to store your text."
        savePanel.prompt = "Save now"
        savePanel.nameFieldLabel = "File name:"
        savePanel.nameFieldStringValue = "mytext"
        
        let response = savePanel.runModal()
        guard response == .OK, let saveURL = savePanel.url else { return }
        
        var contentFile = ""
        
        let priceFormatter =  NumberFormatter.priceFormatter
        
        for item in items {
            let name = item.name?.padding(toLength: 50, withPad: " ", startingAt: 0) ?? ""
            let price = priceFormatter.string(from: NSNumber(floatLiteral: Double(item.price))) ?? ""
            contentFile += "\(name)\(price)\n"
        }
        
        try? contentFile.write(to: saveURL, atomically: true, encoding: .utf8)
        
    }
    
    @MainActor
    private func onPrint() {
        let pi = NSPrintInfo.shared
        pi.topMargin = 72.0
        pi.bottomMargin = 72.0
        pi.leftMargin = 72.0
        pi.rightMargin = 72.0
        pi.verticalPagination = .automatic
        pi.horizontalPagination = .fit
        pi.orientation = .landscape
        pi.isHorizontallyCentered = false
        pi.isVerticallyCentered = false
        pi.scalingFactor = 0.5
        
        let view = NSHostingView(rootView: self)
        let po = NSPrintOperation(view: view, printInfo: pi)
        po.view?.frame = NSRect(x: 0, y: 0, width: 300, height: 300)
        po.printInfo.orientation = .portrait
        po.showsPrintPanel = true
        po.showsProgressPanel = true
        
        po.printPanel.options.insert(NSPrintPanel.Options.showsPaperSize)
        po.printPanel.options.insert(NSPrintPanel.Options.showsOrientation)
        
        if po.run() {
            print("In Print completion")
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
    }
}
