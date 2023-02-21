//
//  KeyPadView.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 06/02/2023.
//

import SwiftUI
import CoreData

struct KeyPadView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @EnvironmentObject var dataProvider: TransactionDataProvider
    
    
    private let tenders = ["Card", "Cash", "Transfer", "QR"]
    
    var body: some View {
        
        VStack {
            TextField("$0.00", value: $dataProvider.total, formatter: NumberFormatter.priceFormatter)
                .textFieldStyle(DefaultTextFieldStyle())
                .font(.title)
                .padding()
                .multilineTextAlignment(.trailing)
                .disabled(true)
            Spacer()
            
            ScrollView {
                ForEach(update(items), id: \.self) {(sections: [Item]) in
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(sections) { item in
                                    ItemView(item: item)                                    .onTapGesture{
                                            dataProvider.saleItem(item: item)
                                        }
                                }
                            }
                        }
                        Divider()
                    } header: {
                        HStack {
                            Text(sections.first?.presentation ?? "")
                                .font(.headline)
                            Spacer()
                        }
                    }
                }
            }.padding()
            
            HStack {
                ForEach(tenders, id: \.self) { name in
                    TenderButtonView(name:name)
                }
            }.padding()
        }
    }
    
    func update(_ result : FetchedResults<Item>)-> [[Item]]{
        
        let results = Dictionary(grouping: result){ (element : Item)  in
            element.presentation
        }.values.sorted() { ($0.first?.presentation ?? "") < ($1.first?.presentation ?? "") }
        
        return results
    }
    
}

struct KeyPadView_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadView()
    }
}
