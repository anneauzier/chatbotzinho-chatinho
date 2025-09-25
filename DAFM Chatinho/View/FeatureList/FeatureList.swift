//
//  FeatureList.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//

import SwiftUI

struct FeatureList: View {
    
    @State var viewModel = FeaturesViewModel()
    
    @State var isSubmited:Bool = false
    
    @State var showSplitView: Bool = false
    
    @State var backlog: ProductBacklog?
    
    @State var isGenerating: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 20) {
                Text("Describe the apps functionalities")
                HStack {
                    TextField("Type your feature here",
                              text: $viewModel.featureText)
                    .onSubmit {
                        viewModel.addNewFeature()
                    }.disabled(isGenerating)
                    Spacer()
                    Button("Add") {
                        viewModel.addNewFeature()
                    }.disabled(isGenerating)
                }
                
                List {
                    ForEach(viewModel.featureList, id:\.self) { feature in
                        Text(feature)
                            .onTapGesture {
                                viewModel.featureToEdit(feature)
                            }
                    }
                }.listStyle(.bordered)
                    .overlay {
                        if isGenerating {
                            VStack {
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                Text("Generating colors...")
                                    .font(.headline)
                                Spacer()
                            }
                        }
                    }
                
                Button("Generate User Stories") {
                    Task {
                        do {
                            isGenerating.toggle()
                            backlog = try await self.viewModel.generateUserStories()
                            isGenerating.toggle()
                            showSplitView.toggle()
                        } catch {
                            print(error)
                        }
                    }
                }.disabled(isGenerating)
            }.padding(8)
                .navigationDestination(isPresented: $showSplitView) {
                    UserSplitView(backlog: backlog)
                }
        }
        
    }
    
    
}

#Preview {
    FeatureList()
    
}
