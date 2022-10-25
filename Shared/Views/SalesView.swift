//
//  SwiftUIView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 25/08/2022.
//

import SwiftUI

struct SalesView: View {
    
    static private var trxUUID: UUID = UUID()
    
    @Binding var total: Float
    @State private var isPresented = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        predicate: NSPredicate(format: "number == %@", SalesView.trxUUID as CVarArg),
        animation: .default)
    private var saleItems: FetchedResults<Transaction>
    
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
                    isPresented.toggle()
                    self.total = 0
                    PDFTicketView.lastTrxUUID = SalesView.trxUUID
                    SalesView.trxUUID = UUID()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(UIColor.systemBlue))
                            .background(Color(UIColor.systemBlue))
                        Text("TOTAL")
                            .font(.headline)
                            .foregroundColor(.white)
                    }.frame(width: 130, height: 60, alignment: .center)
                        .padding()
                }.fullScreenCover(isPresented: $isPresented, content: {
                    PDFTicketView()
                })
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
                                            .lineLimit(2)
                                        Text(NSNumber(value:item.price), formatter: numberFormatter)
                                            .font(.callout)
                                    }
                                    .frame(width: 130, height:80, alignment: .center)
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
                            Text(sections.first?.presentation ?? "")
                                .font(.headline)
                            Spacer()
                        }
                    }
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
    
    private func saleItem(item: Item) {
        
        let newItem = Transaction(context: viewContext)
        newItem.timestamp = Date()
        newItem.name = item.name
        newItem.price = item.price
        
        if saleItems.count == 0 {
            SalesView.trxUUID = UUID()
        }
        
        newItem.number = SalesView.trxUUID
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
        SalesView(total: .constant(0))
    }
}
