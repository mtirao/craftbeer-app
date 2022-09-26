//
//  SwiftUIView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/08/2022.
//

import SwiftUI

struct SalesView: View {
    
    @Binding var total: Float
    @Binding var trxUUID: UUID
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
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
            
            #if os(macOS) || os(tvOS)
            TextField("$0.00", value: $total, formatter: numberFormatter)
                .textFieldStyle(DefaultTextFieldStyle())
                .font(.title)
                .padding()
                .multilineTextAlignment(.trailing)
                .disabled(true)
            #elseif os(iOS)
            TextField("$0.00", value: $total, formatter: numberFormatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .font(.title)
                .padding()
                .multilineTextAlignment(.trailing)
                .disabled(true)
            #endif
            
            ScrollView {
                ForEach(update(items), id: \.self) {(sections: [Item]) in
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(sections) { item in
                                    VStack{
                                        Text(item.name ?? "")
                                            .font(.headline)
                                        Text(NSNumber(value:item.price), formatter: numberFormatter)
                                            .font(.callout)
                                    }.background(Color("color_grayscale_200"))
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.gray)
                                    )
                                    #if os(macOS) || os(iOS)
                                    .onTapGesture{
                                        self.total += item.price
                                        saleItem(item: item)
                                    }
                                    #endif
                                }
                            }
                        }
                        Divider()
                    } header: {
                        HStack {
                            Text(sections[0].presentation!)
                                .font(.headline)
                            Spacer()
                        }
                    }
                }
            }.padding()
            
            /*List {
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
                            Spacer()
                        }
                        #if os(macOS) || os(iOS)
                        .onTapGesture{
                            self.total += item.price
                            saleItem(item: item)
                        }
                        #endif
                    }
                }
            }*/
        }
    }
    
    func update(_ result : FetchedResults<Item>)-> [[Item]]{
        
        let results = Dictionary(grouping: result){ (element : Item)  in
            element.presentation
        }.values.sorted() { $0[0].presentation! < $1[0].presentation! }
        
        return results
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
}

struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView(total: .constant(0), trxUUID: .constant(UUID()))
    }
}
