//
//  RecipeView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI

struct StageView: View {
    
    let stage: StageViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(stage.type)
                    .font(.headline)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
                Spacer()
            }
            HStack {
                Text("\(stage.temp)")
                    .font(.subheadline)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
                Text("\(stage.time)")
                    .font(.subheadline)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
    }
}
