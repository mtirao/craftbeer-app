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
            Form {
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
                    }.frame(width: 190)
                    TextField("Name", text:$name)
                        .padding([.top], 4)
                    Picker("", selection: self.$unit) {
                        ForEach(0 ..< self.units.count, id:\.self) {index in
                            Text(self.units[index]).tag(index)
                        }
                    }.frame(width: 190)
                        .padding([.top], 4)
                    TextField("Value", text:$value)
                        .padding([.top], 4)
                    
                }
            }
            HStack {
                HStack {
                    Button("Save") {
                        self.isVisible = false
                        
                        let ingredient = IngredientViewModel(recipe: self.recipe.recipeId)
                            .name(ingredient: self.name)
                            .value(value: self.value)
                            .unit(unit: self.unit)
                            .type(type: self.types[self.type])
                        
                                           
                        self.recipes.post(ingredient: ingredient)
                    }
                    
                    Spacer()
                    
                    Button("Cancel") {
                        self.isVisible = false
                    }
                    
                }
            }.padding([.top], 16)
        }.padding()
        
    }
}
