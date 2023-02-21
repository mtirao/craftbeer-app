//
//  JournalView.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 06/02/2023.
//

import SwiftUI
import CoreData

struct JournalView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataProvider: TransactionDataProvider
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dataProvider.saleItems, id: \.self) { item in
                    VStack {
                        HStack{
                            Text(item.name ?? "")
                                .font(Font.system(size: 20, weight: .bold))
                                .lineLimit(2)
                                .foregroundColor(Color(Colors.itemBlue.uiColor))
                            Spacer()
                            Text(NSNumber(value:item.price), formatter: NumberFormatter.priceFormatter)
                                .font(Font.system(size: 20, weight: .bold))
                        }
                        HStack {
                            Text(item.itemDescription ?? "")
                                .font(Font.system(size: 20, weight: .medium))
                                .lineLimit(2)
                            Spacer()
                        }
                    }
                    
                }.onDelete(perform: dataProvider.deleteItems)
            }
            .navigationTitle("Receipt" )
            .toolbar {
                EditButton()
            }
        }
    }
    
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
