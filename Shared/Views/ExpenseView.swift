//
//  ExpenseView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 01/04/2023.
//

import SwiftUI

struct ExpenseView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.type, ascending: true)],
        animation: .default)
    private var expenses: FetchedResults<Expense>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses) { item in
                    NavigationLink {
                        ExpenseDetailView(item: item)
                    } label: {
                        Text("\(item.name!)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Expenses")
            .toolbar {
                
                #if os(iOS)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                #endif
                
                #if os(iOS)
                ToolbarItem {
                    EditButton()
                }
                #endif
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Expense(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = "#Unnamed"
            newItem.type = "Rent"
            newItem.quantity = 1
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { expenses[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
    }
}
