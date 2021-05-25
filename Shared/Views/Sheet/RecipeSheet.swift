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
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                TextField("Style", text:$style)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
            
                TextField("IBU", text:$ibu)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                TextField("ABV", text:$abv)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                TextField("Color", text:$color)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                
            }
            
            HStack {
                Spacer()
                
                Button(action:saveRecipe) {
                    Text("Save")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.white)
                }.background(Color("wannaka_red"))
                .cornerRadius(16)
            }.padding()
            
            HStack {
                Spacer()
                
                Button("Cancel") {
                    self.isVisible = false
                }.foregroundColor(Color.black)
                
                Spacer()
                
            }
        }
        .padding()
    }
    
    func saveRecipe() {
        let recipe = RecipeViewModel()
                        .name(recipe: self.name)
                        .style(recipe: self.style)
                        .ibu(recipe: self.ibu)
                        .abv(recipe: self.abv)
                        .color(recipe: self.color)
        
        
                           
        self.recipes.post(recipe: recipe)
        
        
        self.isVisible = false
    }
    
}

