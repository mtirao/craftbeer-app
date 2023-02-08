//
//  ItemView.swift
//  Craftbeer (iOS)
//
//  Created by Marcos Tirao on 06/02/2023.
//

import SwiftUI

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        
        VStack{
            Text(item.name ?? "")
                .font(.headline)
                .lineLimit(2)
            Text(NSNumber(value:item.price), formatter: NumberFormatter.priceFormatter)
                .font(.callout)
        }
        .frame(width: 130, height:80, alignment: .center)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray)
        )
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item())
    }
}
