//
//  IngredientSheetView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 06/12/2020.
//

import SwiftUI

struct IngredientSheet: View {
    
    @Binding var isVisible: Bool
    
    @State private var name: String = ""
    @State private var value: String = ""
    
    var types = ["Malt", "Yeast", "Water", "Hop"]
    var units = ["Kilo", "Grams", "Liter"]
    
    
    @EnvironmentObject  var ingredientProvider : IngredientDataProvider
    
    
    let recipeId: Int
    let unitType: UnitEnum
    let type: TypeEnum
    
    var body: some View {
        VStack {
            
            Section(header: HStack(alignment: .top) {
                Text("New Ingredient: ")
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                Spacer()
            }) {
                
                TextField("Name", text:$name)
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
                
                TextField("Value", text:$value)
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
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
        
        
        
        let ingredient = IngredientViewModel(ingredient: Ingredient(id: nil,
                        recipe: self.recipeId,
                        name: self.name,
                        type: type  /*TypeEnum(rawValue: self.types[self.type].lowercased())*/,
                        unit: unitType /*UnitEnum(rawValue: self.unit + 1)*/,
                        value: Int(self.value)))
        
                           
        self.ingredientProvider.post(ingredient: ingredient)
    }
}
