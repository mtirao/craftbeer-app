//
//  IngredientSheetView.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 06/12/2020.
//

import SwiftUI

struct StageSheet: View {
    
    @Binding var isVisible: Bool
    
    @State private var stage: Int = 0
    @State private var temp: String = ""
    @State private var time: String = ""
    
    var stages = ["Mash", "Liquor", "Boil", "Fermetation", "Wash"]
    
    let recipe: RecipeViewModel

    @EnvironmentObject  var recipes : RecipeDataProvider
    
    var body: some View {
        VStack {
            
            Section(header: HStack(alignment: .top) {
                Text("New Stage: ")
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                Spacer()
            }) {
                
                Picker("", selection: self.$stage ) {
                    ForEach(0 ..< self.stages.count, id:\.self) {index in
                        Text(self.stages[index]).tag(index)
                    }
                }.frame(width: 190)
                
                TextField("Temp", text:$temp)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
               
                TextField("Ttime", text:$time)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )

            }
            
            
            HStack {
                Spacer()
                
                Button(action:saveStage) {
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
    
    func saveStage() {
        
        let stage = StageViewModel(stage: Stage(id: nil,
                                                recipe: self.recipe.recipeId,
                                                type: StageEnum(rawValue: self.stage),
                                                temp: Int(self.temp),
                                                time: Int(self.time)))
        
        self.recipes.post(stage: stage)
        
        self.isVisible = false
    }
}
