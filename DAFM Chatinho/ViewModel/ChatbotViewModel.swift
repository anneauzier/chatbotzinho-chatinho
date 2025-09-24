//
//  ChatbotViewModel.swift
//  DAFM Chatinho
//
//  Created by Anne Auzier on 24/09/25.
//

import SwiftUI
import Combine
import FoundationModels

@MainActor
class ChatbotViewModel: ObservableObject {

    @Published var prompt: String = ""
    @Published var isShowingInspector = false
    
    @Published var temperature: Double = 0.7
    @Published var maximumResponseTokens: Int = 200
    @Published var instructions: String = ""
    
    @Published var messages: [String] = []
    
    func scrollToBottom(scrollView: ScrollViewProxy) {
        withAnimation {
            scrollView.scrollTo("bottom", anchor: .bottom)
        }
    }
    
    func generate() async {
        let input = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !input.isEmpty else { return }
        
        do {
            let session = LanguageModelSession(instructions: instructions)
            let options = GenerationOptions(temperature: temperature, maximumResponseTokens: maximumResponseTokens)
            let response = session.streamResponse(to: input, options: options)
            
            messages.append("")
            for try await partialMessage in response {
                messages.removeLast()
                messages.append(partialMessage.content)
               
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
