import SwiftUI
import FoundationModels
import Playgrounds

struct Message: Codable, Hashable, Identifiable, Sendable {
    public enum Role: Codable, Hashable, Sendable {
        case user
        case assistant
    }
    public var id = UUID()
    public var text: String
    public var role: Role = .user
    public var creationDate: Date = Date()
}

@MainActor @Observable
class Chat {
    var messages: [Message] = []
    
    func addMessage(_ message: Message) {
        messages.append(message)
    }
}

struct ContentView: View {
    @State private var prompt: String = ""
    @State private var chat = Chat()
    @State private var isShowingInspector = false
    
    @State private var temperature: Double = 0.7
    @State private var maximumResponseTokens: Int = 200
    @State private var instructions: String = ""
    
    @State private var session: LanguageModelSession?
    
    let sampleQuestions: [String] = [
        "What is the capital of Brazil?",
        "Who wrote 'To Kill a Mockingbird'?",
        "What are the 5 most populated cities in the world?",
    ]
    
    private let tokenFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        return formatter
    }()
    
    var body: some View {
        VStack {
            switch SystemLanguageModel.default.availability {
            case .available:
                messagesList
                    .onAppear {
                        chat.messages.append(Message(text: "Hello! I'm here to assist you. Feel free to ask me anything.", role: .assistant))
                    }
                    .task {
                        session = LanguageModelSession(instructions: instructions)
                    }
                    .safeAreaInset(edge: .bottom) {
                        HStack {
                            TextField("Type your message here and press ⏎", text: $prompt)
                                .padding(5)
                                .textFieldStyle(.plain)
                                .padding(5)
                                .glassEffect()
                                .onSubmit {
                                    chat.messages.append(Message(text: prompt, role: .user))
                                    Task {
                                        chat.messages.append(Message(text: "", role: .assistant))
                                        await generate()
                                    }
                                }
                        }
                        .padding()
                    }
                    .toolbar {
                        ToolbarItem {
                            Button {
                                chat.messages.removeAll()
                            } label: {
                                Image(systemName: "eraser")
                            }
                        }
                        ToolbarSpacer(.flexible)
                        ToolbarItem {
                            Button {
                                isShowingInspector.toggle()
                            } label: {
                                Image(systemName: "sidebar.trailing")
                            }
                            
                        }
                    }
                    .inspector(isPresented: $isShowingInspector) {
                        VStack(alignment: .leading) {
                            Text("Generation Options")
                                .font(.headline)
                                .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                Text("Temperature: \(temperature, specifier: "%.1f")")
                                    .font(.callout)
                                    .monospacedDigit()
                                Slider(value: $temperature, in: 0.0...1.0, step: 0.1)
                            }
                            .padding(.bottom)
                            
                            HStack {
                                Text("Max ToKens:")
                                    .font(.callout)
                                TextField("Enter a number", value: $maximumResponseTokens, formatter: tokenFormatter)
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                Text("Instructions:")
                                    .font(.callout)
                                TextEditor(text: $instructions)
                                    .frame(height: 80)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
            case .unavailable(.deviceNotEligible):
                ContentUnavailableView("Error", systemImage: "xmark.octagon", description: Text("Device not eligible!"))
            case .unavailable(.appleIntelligenceNotEnabled):
                // Ask the person to turn on Apple Intelligence.
                ContentUnavailableView("Error", systemImage: "xmark.octagon", description: Text("Apple Intelligence is not enabled!"))
            case .unavailable(.modelNotReady):
                // The model isn't ready because it's downloading or because of other system reasons.
                ContentUnavailableView("Error", systemImage: "xmark.octagon", description: Text("Model is not ready!"))
            case .unavailable(let other):
                let errorDescription = "Unknown error: \(String(describing: other))"
                ContentUnavailableView("Error", systemImage: "xmark.octagon", description: Text(errorDescription))
            }
        }
    }
    
    @ViewBuilder
    var message: some View {
        let dateFormatter = Date.FormatStyle(date: .abbreviated, time: .standard)
        let lastMessageAssistantID = chat.messages.last(where: { $0.role == .assistant })?.id
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Group {
                    
                    
                    ForEach(sampleQuestions, id: \.self) { question in
                        Button(question) {
                            prompt = question
                            Task { await generate() }
                        }
                    }
                }
                .buttonStyle(.borderless)
                .padding()
                .glassEffect()
            }
            
            ForEach(chat.messages) { message in
                HStack {
                    if message.role == .user {
                        Spacer()
                    }
                    
                    VStack(alignment: message.role == .assistant ? .leading : .trailing) {
                        if message.role == .assistant, let session, session.isResponding, message.id == lastMessageAssistantID {
                            ProgressView()
                                .padding(8)
                                .glassEffect(in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(Color(.white))
                                .controlSize(.small)
                        } else {
                            Text(message.text)
                                .padding(8)
                                .glassEffect(in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(message.role == .user ? Color(.blue) : Color(.white))
                        }
                        
                        Text(message.creationDate, format: dateFormatter)
                            .font(.caption2.italic())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    if message.role == .assistant {
                        Spacer()
                    }
                    
                }
                .padding(.horizontal, 5)
            }
        }
    }
    
    @ViewBuilder
    var messagesList: some View {
        ScrollView {
            ScrollViewReader { scrollView in
                message
                    .onAppear {
                        scrollToBottom(scrollView: scrollView)
                    }
                    .onChange(of: chat.messages) { _, _ in
                        scrollToBottom(scrollView: scrollView)
                    }
            }
        }
    }
    
    private func scrollToBottom(scrollView: ScrollViewProxy) {
        if let lastMessage = chat.messages.last {
            withAnimation {
                scrollView.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
    
    private func generate() async {
        if let session {
            //            do {
            //                let response = try await session.respond(to: prompt, options: options)
            //
            //                if let lastIndex = chat.messages.lastIndex(where: { $0.role == .assistant }) {
            //                    chat.messages[lastIndex].text = response.content
            //                }
            //
            //            } catch {
            //                print("Error generating response: \(error)")
            //            }
            
            //            let options = GenerationOptions(temperature: temperature, maximumResponseTokens: maximumResponseTokens)
//            Task { @MainActor in
//                do {
//                    if let lastIndex = chat.messages.lastIndex(where: { $0.role == .assistant }) {
//                        let stream = session.streamResponse(to: prompt, options: options)
//                        for try await chunk in stream {
//                            chat.messages[lastIndex].text = chunk
//                        }
//                    }
//                } catch {
//                    print("Error generating response: \(error)")
//                }
//            }
            Task {
                var assistantMessage = Message(text: "", role: .assistant)
                chat.messages.append(assistantMessage)
                
                let options = GenerationOptions(temperature: temperature, maximumResponseTokens: maximumResponseTokens)
                let stream = session.streamResponse(to: self.prompt, options: options)
                
                for try await chunk in stream {
//                    assistantMessage.text = chunk.content
                    chat.messages[chat.messages.count - 1].text = chunk.content
                }
//                if let lastIndex = chat.messages.lastIndex(where: { $0.role == .assistant }) {
//                    
//                    for try await chunk in stream {
//                        chat.messages[lastIndex].text = chunk.content
//                        chat.messages[messages.count - 1] =
//                    }
//                }
            }
        }
    }
}

#Preview {
    ContentView()
}

#Playground("Playground") {
    let session = LanguageModelSession()
    let response = try await session.respond(to: "Write a Swift function")
    print(response.content)
}
