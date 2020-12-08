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
    
    
    @EnvironmentObject  var recipes : RecipeDataProvider 
    
    var body: some View {
        VStack {
            Section(header:
                HStack(alignment: .top) {
                    Text("New Recipe: ")
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                        .frame(minWidth: 20.0)
                    Spacer()
                }
            ) {
                TextField("Name", text:$name)
                TextField("Style", text:$style)
                TextField("IBU", text:$ibu)
                TextField("ABV", text:$abv)
                TextField("Color", text:$color)
                
            }
            
            HStack {
                Button("Save") {
                    
                    let recipe = RecipeViewModel()
                                    .name(recipe: self.name)
                                    .style(recipe: self.style)
                                    .ibu(recipe: self.ibu)
                                    .abv(recipe: self.abv)
                                    .color(recipe: self.color)
                    
                    
                                       
                    self.recipes.post(recipe: recipe)
                    
                    
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

