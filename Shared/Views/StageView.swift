//
//  RecipeView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 28/10/2020.
//

import SwiftUI

struct StageView: View {
    
    let stage: StageViewModel
    
    #if os(tvOS)
        let width: CGFloat = 220
        let height: CGFloat = 100
    #else
        let width: CGFloat = 100
        let height: CGFloat = 90
    #endif
    
    var body: some View {
        VStack {
            HStack {
                Text(stage.typeT)
                    .font(.footnote)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    .foregroundColor(Color.black)
            }
            HStack {
                Text("\(stage.tempT)")
                    .font(.caption)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
                Text("\(stage.timeT)")
                    .font(.caption)
                    .opacity(0.625)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.middle)
                    .foregroundColor(Color.black)
            }
        }.frame(width: width, height: height)
        .background(Color("color_grayscale_200"))
        .cornerRadius(16)
    }
}
