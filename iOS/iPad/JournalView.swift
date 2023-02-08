//
//  JournalView.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 06/02/2023.
//

import SwiftUI

struct JournalView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        predicate: NSPredicate(format: "timestamp >= %@", date(from: Date()) as CVarArg),
        animation: .default)
    private var saleItems: FetchedResults<Transaction>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(saleItems, id: \.self) { item in
                    Section {
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
                            HStack {
                                Text("Transaction: " + (item.number?.uuidString ?? ""))
                                    .font(Font.system(size: 15, weight: .medium))
                                    .lineLimit(2)
                                Spacer()
                            }
                        }.padding([.leading, .trailing], 32)
                    }.frame(width: 550)
                }
            }.navigationTitle("Sales for: \(DateFormatter.dateFormatter.string(from: Date()))" )
        }
    }
    
    static private func date(from: Date) -> Date {
        let date = DateFormatter.dateFormatter.string(from: from)
        return DateFormatter.dateFormatter.date(from: date)!
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
