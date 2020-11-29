//
//  RecipeSheet.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 03/11/2020.
//

import SwiftUI

struct RecipeSheet: View {
    
    @Binding var isVisible: Bool
    
    
    @State var name: String = ""
    @State var style: String = ""
    @State var ibu: String = ""
    @State var abv: String = ""
    @State var color: String = ""
    
    var body: some View {
        VStack {
            Section(header:
                HStack(alignment: .top) {Text("New Recipe: ")
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                    Spacer()
                }
            ) {
                TextField("Number", text:$name)
                TextField("Summary", text:$style)
                TextField("IBU", text:$ibu)
                TextField("ABV", text:$abv)
                TextField("Color", text:$color)
                
            }
            
            HStack {
                Button("Save") {
                    
                  /* let mantis = MantisViewModel(number: self.number,
                                                summary: self.summary,
                                                customer: self.customer)
                                       
                                       
                    self.postIncident.post(incident: mantis)
                    */
                    
                    self.isVisible = false
                    
                }
                
                Spacer()
                
                Button("Cancel") {
                    self.isVisible = false
                }
                
                
            }
        }.frame(width: 200, height: 190)
        .padding()
    }
}

