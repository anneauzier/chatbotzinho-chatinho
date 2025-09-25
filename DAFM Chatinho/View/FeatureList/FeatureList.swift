//
//  FeatureList.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//

import SwiftUI

struct FeatureList: View {
    
    @Environment(BacklogStore.self) var backlogStore
    
    @State var viewModel = FeaturesViewModel()

    @State var isSubmited:Bool = false
    
    @State var showSplitView: Bool = false
    @State var backlog: ProductBacklog?
    
    @Binding var isCreating: Bool
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 20) {
                Text("Describe the apps functionalities")
                HStack {
                    TextField("Type your feature here",
                              text: $viewModel.featureText)
                    .onSubmit {
                        viewModel.addNewFeature()
                    }
                    Spacer()
                    Button("Add") {
                        viewModel.addNewFeature()
                    }
                }
                List {
                    ForEach(viewModel.featureList, id:\.self) { feature in
                        Text(feature)
                            .onTapGesture {
                                viewModel.featureToEdit(feature)
                            }
                    }
                }.listStyle(.bordered)
                Button("Generate User Stories") {
                    Task {
                        do {
                            backlog = try await self.viewModel.generateUserStories()
                            guard let newBacklog = backlog else { return }
                            backlogStore.backlogs.append(newBacklog)
                            backlogStore.selectedBacklog = newBacklog
                            isCreating = false
                        } catch {
                            print(error)
                        }
                    }
                }
            }.padding(8)
        }
        
    }
    

}

#Preview {
//    FeatureList()

}
