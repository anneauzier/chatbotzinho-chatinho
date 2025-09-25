//
//  ScrumView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 24/09/25.
//

import SwiftUI
import FoundationModels

struct ScrumView: View {
    @State var functionalities: [String] = []
    @State var prompt: String = ""
    @State private var isGenerating = false
    @State var featureDescription: String = ""
    @State var backlog: ProductBacklog?

    var body: some View {
        if isGenerating {
            VStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Text("Generating colors...")
                    .font(.headline)
            }
        } else {
            NavigationStack{
                NavigationLink("Generate", destination: UserSplitView(backlog: backlog))
                
                ScrollView{
                    TextField("Type your functionality here and press ⏎", text: $featureDescription)
                        .padding(5)
                        .textFieldStyle(.plain)
                        .padding(5)
                        .glassEffect()
                        .onSubmit {
                            functionalities.append(featureDescription)
                        }
                    
                    List {
                        ForEach(functionalities, id: \.self) { functionality in
                            Text(functionality)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        prompt = functionalities.joined(separator: ", ")
                        Task{
                            await generate()
                        }
                    } label: {
                        Text("Generate")
                    }
                }
            }
        }
    }
    
    func generate() async {
        do {
            let session = LanguageModelSession(instructions: "generate a product backlog following the SCRUM principles for an iOS development project, with design and coder roles. The prompt in providing the apps main feature. The output must be  list of user stories based on the feature description.")
            
            let result = try await session.respond(to: featureDescription,
                                                   generating: ProductBacklog.self)
            
            backlog = result.content

        } catch {
            print(error.localizedDescription)
        }
    }
    
}
