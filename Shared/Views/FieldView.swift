//
//  FieldView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 01/11/2020.
//

import SwiftUI

struct FieldView: View {
    
    let text: String
    
    @Binding var fieldText: String
        
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(text)
            TextField(text, text: $fieldText)
                .font(.headline)
                .truncationMode(.tail)
                .frame(minWidth: 20.0)
                .foregroundColor(Color.gray)
                .textFieldStyle(PlainTextFieldStyle())
        }
        
        
    }
    
}

