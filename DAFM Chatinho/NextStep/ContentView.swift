//
//  ContentView.swift
//  POC-BacklogGenerator
//
//  Created by Igor Vicente on 24/09/25.
//

import SwiftUI
import FoundationModels
import Playgrounds

struct ContentView: View {
    
    @State var featureDescription: String = ""
    @State var backlog: ProductBacklog?
    
    var body: some View {
        VStack {
            
            TextField("Feature description", text: $featureDescription)
                
            Button("Generate") {
                Task {
                    await generateBacklog()
                }
            }
        }
        .padding()
        
    }
    
    func generateBacklog() async {
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

#Playground("Backlog") {
    let session = LanguageModelSession(instructions: "generate a product backlog following the SCRUM principles for an iOS development project, with design and coder roles. The prompt in providing the apps main feature. The output must be  list of user stories based on the feature description. Each featire is separated by the '|' charactere.")
    
    let result = try await session.respond(to: "get user location | get current weather for the user location | list of capital cities of brasil for user selection | show current weather for user selection city",
                                           generating: ProductBacklog.self)
}

#Preview {
    ContentView()
}
