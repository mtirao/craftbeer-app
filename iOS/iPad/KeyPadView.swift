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
    private let tables = ["Store", "Table 1", "Table 2", "Table 3", "Table 4"]
    
    var body: some View {
        
        VStack {
             
            TextField("$0.00", value: $dataProvider.total, formatter: NumberFormatter.priceFormatter)
                .textFieldStyle(DefaultTextFieldStyle())
                .font(.system(size: 40))
                .padding()
                .multilineTextAlignment(.trailing)
                .disabled(true)
            #if !os(macOS)
                .foregroundColor(Colors.wanakaRed.color)
            #endif
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
            }
            
            VStack {
                HStack {
                    ForEach(tenders, id: \.self) { name in
                        TenderButtonView(name:name)
                    }
                }
                
                HStack {
                    ForEach(Array(tables.enumerated()), id: \.offset) { index, element in
                        TableButtonView(number: index, name: element)
                    }
                }.padding(.bottom, 8)
            }
            
        }.onAppear {
            dataProvider.switchTable(table: 0)
        }
#if os(macOS)
        .frame(width: 1024)
#else
        .frame(width: UIScreen.main.bounds.width * 0.62)
#endif
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
