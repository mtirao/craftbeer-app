//
//  TransactionViewModel.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 21/02/2023.
//

import Foundation
import CoreData
import SwiftUI

class TransactionDataProvider: ObservableObject {
    
    var viewContext: NSManagedObjectContext!
    var tablesUUID: [UUID] = [UUID(), UUID(), UUID(), UUID()]
    var currentUUID = UUID()
    
    @Published var saleItems: [Transaction] = []
    @Published var total: Float = 0.0
    
    func switchTable(table: Int) {
        self.currentUUID = tablesUUID[table]
    }
    
    func getTransactionItems() {
        
        let fetchRequest: NSFetchRequest<Transaction>
        fetchRequest = Transaction.fetchRequest()

        // Add a predicate for entities with a name
        // attribute equal to "Apple"
        fetchRequest.predicate = NSPredicate(
            format:  "number == %@", currentUUID as CVarArg
        )

        // Perform the fetch request to get the objects
        // matching the predicate
        do {
            saleItems = try viewContext.fetch(fetchRequest)
            computeTotal()
        }catch {
            print("Error ocurred")
        }
    }
    
   func commitTransaction(name: String) {
        
        let tender = Tender(context: viewContext)
        let total = saleItems.reduce(0.0){ $0 + $1.price }
        
        tender.timestamp = Date()
        tender.amount = total
        tender.number = currentUUID
        tender.name = name
        
        do {
            try viewContext.save()
            self.total = 0.0
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
       
       if let index = tablesUUID.firstIndex(where: { $0 == currentUUID }) {
           tablesUUID[index] = UUID()
           currentUUID = tablesUUID[index]
       }
       
    }
    
   func saleItem(item: Item) {
        
        let newItem = Transaction(context: viewContext)
        newItem.timestamp = Date()
        newItem.name = item.name
        newItem.price = item.price
        newItem.purchasePrice = item.purchasePrice
        newItem.itemDescription = item.itemDescription
        
        newItem.number = currentUUID
        newItem.presentation = item.presentation
        newItem.quantity = 1

        do {
            try viewContext.save()
            
            getTransactionItems()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { saleItems[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
                getTransactionItems()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func computeTotal() {
        total = saleItems.reduce(0){$0 + $1.price}
    }
}
