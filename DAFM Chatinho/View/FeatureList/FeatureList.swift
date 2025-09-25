//
//  FeatureList.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//

import SwiftUI

struct FeatureList: View {
    
    @State var featureList:[String] = []
    
    @State var featureText: String = ""
    @State var isSubmited:Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Describe the apps functionalities")
            HStack {
                TextField("Type your feature here",
                          text: $featureText)
                .onSubmit {
                    addNewFeature()
                }
                Spacer()
                Button("Add") {
                    addNewFeature()
                }
            }
            List {
                ForEach(featureList, id:\.self) { feature in
                    Text(feature)
                }
            }.listStyle(.bordered)
            Button("Generate User Stories") {
                //TODO
            }
        }.padding(8)
    }
    
    func addNewFeature() {
        featureList.append(featureText)
        featureText = ""
    }
}

#Preview {
    FeatureList()
}
