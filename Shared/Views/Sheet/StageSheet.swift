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
    
    let recipeId: Int
    let stageType: StageEnum

    @EnvironmentObject  var recipes : RecipeDataProvider
    
    var body: some View {
        VStack {
            
            Section(header: HStack(alignment: .top) {
                Text("New settings for stage " + stages[stageType.rawValue - 1] + ":")
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .frame(minWidth: 20.0)
                Spacer()
            }) {
                
                TextField("Temp", text:$temp)
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("wannaka_red"), lineWidth: 1)
                            .frame(height:40)
                    )
               
                TextField("Ttime", text:$time)
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
                                                recipe: self.recipeId,
                                                type: stageType,
                                                temp: (Int(self.temp) ?? 0) * 100,
                                                time: Int(self.time)))
        
        self.recipes.post(stage: stage)
        
        self.isVisible = false
    }
}
