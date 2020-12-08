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
            Form {
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
                        .padding([.top], 4)
                    
                    TextField("Time", text:$time)
                        .padding([.top], 4)
                    
                }
            }
            HStack {
                HStack {
                    Button("Save") {
                        let stage = StageViewModel(recipe: self.recipe.recipeId)
                            .type(type: self.stage)
                            .temp(temp: self.temp)
                            .time(time: self.time)
                        
                        self.recipes.post(stage: stage)
                        
                        self.isVisible = false
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
