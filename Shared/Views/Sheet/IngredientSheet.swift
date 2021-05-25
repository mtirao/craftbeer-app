//
//  IngredientSheetView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 06/12/2020.
//

import SwiftUI

struct IngredientSheet: View {
    
    @Binding var isVisible: Bool
    
    @State private var type: Int = 0
    @State private var name: String = ""
    @State private var unit: Int = 0
    @State private var value: String = ""
    
    var types = ["Malt", "Yeast", "Water", "Hop"]
    var units = ["Kilo", "Grams", "Liter"]
    
    
    @EnvironmentObject  var recipes : RecipeDataProvider 
    
    let recipe: RecipeViewModel
    
    var body: some View {
        VStack {
            
            Section(header: HStack(alignment: .top) {
                Text("New Ingredient: ")
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                Spacer()
            }) {
                
               
                Picker("", selection: self.$type) {
                    ForEach(0 ..< self.types.count, id:\.self) {index in
                        Text(self.types[index]).tag(index)
                    }
                }
                
                
                TextField("Name", text:$name)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                
                Picker("", selection: self.$unit) {
                    ForEach(0 ..< self.units.count, id:\.self) {index in
                        Text(self.units[index]).tag(index)
                    }
                }
                
                TextField("Value", text:$value)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                
            }
            
            HStack {
                Spacer()
                
                Button(action:saveIngredient) {
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
            
        }.padding()
        
    }
    
    func saveIngredient() {
        self.isVisible = false
        
        let ingredient = IngredientViewModel(recipe: self.recipe.recipeId)
            .name(ingredient: self.name)
            .value(value: self.value)
            .unit(unit: self.unit)
            .type(type: self.types[self.type])
        
                           
        self.recipes.post(ingredient: ingredient)
    }
}
