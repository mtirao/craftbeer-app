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
                    
                    #if os(macOS)
                    Button(action: saveRecipe){
                        Image(systemName: "tray.and.arrow.down")
                    }.buttonStyle(BorderlessButtonStyle())
                    
                    Button(action: {
                        self.isVisible = false
                    }){
                        Image(systemName: "xmark")
                    }.buttonStyle(BorderlessButtonStyle())
                    #endif
                }
            ) {
               
                TextField("Name", text:$name)
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                TextField("Style", text:$style)
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
            
                TextField("IBU", text:$ibu)
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                TextField("ABV", text:$abv)
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                TextField("Color", text:$color)
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                
            }
            
            #if !os(macOS)
            
            HStack {
                
                Button(action: saveRecipe){
                    Text("Save")
                        .font(.system(size: 18))
                }.buttonStyle(BorderlessButtonStyle())
                
            }
            
            HStack {
                Spacer()
                
                Button("Cancel") {
                    self.isVisible = false
                }.foregroundColor(Color.black)
                
                Spacer()
                
            }
            #endif
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

