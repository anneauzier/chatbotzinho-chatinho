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
    @State var text: String = ""
    @State var prompt: String = ""
    @State private var isGenerating = false
    
    @State private var stories: StoryModel = StoryModel(text: "aa")
    //final model
//    @State private var stories: [StoryModel] = []
    
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
                NavigationLink("Resultado", destination: UserSplitView())
                ScrollView{
                    TextField("Type your functionality here and press ⏎", text: $text)
                        .padding(5)
                        .textFieldStyle(.plain)
                        .padding(5)
                        .glassEffect()
                        .onSubmit {
                            functionalities.append(text)
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
            let session = LanguageModelSession(instructions: "You are a scrum specialist, you are creating the Kanban backlog, generate user stories based on prompt")
            let result = try await session.respond(to: prompt, generating: StoryModel.self)
            
            stories = result.content
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
