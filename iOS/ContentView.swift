//
//  ContentView.swift
//  Shared
//
//  Created by Marcos Tirao on 23/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    private var currentRecipe = -1
    
    @State private var selection: String? = nil
    
    @StateObject var recipes = RecipeDataProvider()
    
    @State private var searchText = ""
    @State private var showingSheet = false
    
    @State private var name: String = ""
    @State private var presentation: String = ""
    @State private var price: Float = 0
    
    @State private var showDetail = false

    @State private var total: Float = 0
    
    @Environment(\.managedObjectContext) private var viewContext

    @State private var trxUUID = UUID()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        animation: .default)
    private var transaction: FetchedResults<Transaction>
    
    var body: some View {
        
        TabView {
            recipesView()
                .tabItem{
                    Label("Recipes", systemImage: "list.dash")
                }
            stockView()
                .tabItem{
                    Label("Stock", systemImage: "cart")
                }
            
            salesView()
                .tabItem{
                    Label("Sales", systemImage: "bag")
                }
                .onAppear{
                    self.trxUUID = UUID()
                    self.total = 0
                }
            
            transactionView()
                .tabItem{
                    Label("Transaction", systemImage: "creditcard.fill")
                }
            
        }
        
    }
    
    @ViewBuilder private func transactionView() -> some View {
        NavigationView {
            List {
                ForEach(transaction.filter({$0.number == trxUUID})) { item in
                    VStack{
                        Text(item.name ?? "")
                            .font(.headline)
                        Text(item.presentation ?? "")
                            .font(.callout)
                        Text(NSNumber(value:item.price), formatter: numberFormatter)
                            .font(.callout)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
    
    @ViewBuilder private func salesView() -> some View {
        VStack {
            
            HStack{
                Spacer()
                Button(action: {
                    self.total = 0
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding(.trailing, 8)
                }
            }
            
            TextField("$0.00", value: $total, formatter: numberFormatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .font(.title)
                .padding()
                .multilineTextAlignment(.trailing)
                .disabled(true)
            
            
            List {
                VStack {
                    ForEach(items) { item in
                        
                        VStack {
                            HStack {
                                Text(item.name ?? "")
                                    .font(.headline)
                                Spacer()
                            }
                            HStack {
                                Text(item.presentation ?? "")
                                    .font(.callout)
                                Spacer()
                                Text(NSNumber(value: item.price), formatter: numberFormatter)
                                    .font(.callout)
                            }
                        }.onTapGesture{
                            self.total += item.price
                            saleItem(item: item)
                        }
                    }
                }
            }
        }
    }
 
    
    @ViewBuilder private func stockView() -> some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(isActive: $showDetail) {
                        Form {
                            Section(header: Text("Item")) {
                                TextField("Name", text: $name)
                                TextField("Presentation", text: $presentation)
                                TextField("$0.00", value: $price, formatter: numberFormatter)
                            }
                        }.toolbar{
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    updateItem(item: item)
                                }) {
                                    Label("Save Item", systemImage: "square.and.arrow.down")
                                }
                            }
                        }
                    } label: {
                        Text("\(item.name!)")
                    }.onAppear(perform: {
                        self.name = item.name ?? ""
                        self.presentation = item.presentation ?? ""
                    })
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
    
    @ViewBuilder private func recipesView() -> some View {
        VStack {
            NavigationView {
                
                List {
                    ForEach(recipes.recipeList.indices) { index in
                        let detail = recipes.recipeList[index]
                        NavigationLink(
                            destination:
                                RecipeViewDetail(recipe:detail),
                            tag:"\(index)",
                            selection: $selection) {
                            RecipeView(recipe: recipes.recipeList[index])
                                .frame(height:80)
                        }

                    }
                   
                }.id(UUID())
                .navigationTitle("Craftbeer")
                .toolbar{
                    ToolbarItem {
                        Button(action: {
                            self.recipes.addRecipe()
                        }){
                            Label("New Recipe", systemImage: "plus")
                        }
                    }
                }
                .listStyle(PlainListStyle())
    
                
            }.onAppear() {
                self.recipes.fetchAll()
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    private func updateItem(item: Item) {
        
        item.name = self.name
        item.presentation = self.presentation
        item.price = Float(self.price)
        
        do {
            try viewContext.save()
            self.showDetail = false
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = "Unnamed"

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
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func saleItem(item: Item) {
        
        let newItem = Transaction(context: viewContext)
        newItem.timestamp = Date()
        newItem.name = item.name
        newItem.price = item.price
        newItem.number = self.trxUUID
        newItem.presentation = item.presentation
        newItem.quantity = 1

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
