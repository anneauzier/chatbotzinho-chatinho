import SwiftUI
import FoundationModels
import Playgrounds
import MarkdownUI

struct ChatbotView: View {

    @StateObject private var chatViewModel = ChatbotViewModel()

    var body: some View {
        VStack {
            switch SystemLanguageModel.default.availability {
            case .available:
                messagesList
                    .task {}
                    .safeAreaInset(edge: .bottom) {
                        HStack {
                            TextField("Type your message here and press ⏎", text: $chatViewModel.prompt)
                                .padding(5)
                                .textFieldStyle(.plain)
                                .padding(5)
                                .glassEffect()
                                .onSubmit {
                                    let chatMessage = ChatMessage(message: chatViewModel.prompt, isFromChat: false)
                                    chatViewModel.messages.append(chatMessage)
                                    Task { await chatViewModel.generate() }
                                }
                        }
                        .padding()
                    }
                    .toolbar {
                        ToolbarItem {
                            Button {
                                chatViewModel.messages.removeAll()
                            } label: {
                                Image(systemName: "eraser")
                            }
                        }
                        ToolbarSpacer(.flexible)
                        ToolbarItem {
                            Button {
                                chatViewModel.isShowingInspector.toggle()
                            } label: {
                                Image(systemName: "sidebar.trailing")
                            }
                            
                        }
                    }
                    .inspector(isPresented: $chatViewModel.isShowingInspector) {
                        VStack(alignment: .leading) {
                            
                            Text("Generation Options")
                                .font(.headline)
                                .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                Text("Temperature: \(chatViewModel.temperature, specifier: "%.1f")")
                                    .font(.callout)
                                    .monospacedDigit()
                                Slider(value: $chatViewModel.temperature, in: 0.0...1.0, step: 0.1)
                            }
                            .padding(.bottom)
                            
                            HStack {
                                Text("Max ToKens:")
                                    .font(.callout)
                                TextField("Enter a number", value: $chatViewModel.maximumResponseTokens, formatter: chatViewModel.tokenFormatter)
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                Text("Instructions:")
                                    .font(.callout)
                                TextEditor(text: $chatViewModel.instructions)
                                    .frame(height: 80)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
            case .unavailable(_):
                ContentUnavailableView("Apple Intelligence is not available.", systemImage: "exclamationmark.octagon")
            }
        }
    }
    
    @ViewBuilder
    var message: some View {
        let _ = Date.FormatStyle(date: .abbreviated, time: .standard)
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Group {
                    ForEach(chatViewModel.sampleQuestions, id: \.self) { question in
                        Button(question) {
                            chatViewModel.prompt = question
                            let chatMessage = ChatMessage(message: chatViewModel.prompt, isFromChat: false)
                            chatViewModel.messages.append(chatMessage)
                            Task { await chatViewModel.generate() }
                        }
                    }
                }
                .buttonStyle(.borderless)
                .padding()
                .glassEffect()
            }
        }
    }
    
    @ViewBuilder
    var messagesList: some View {
        ScrollView {
            ScrollViewReader { scrollView in
                VStack(alignment: .leading, spacing: 12) {
                    message
                    ForEach(chatViewModel.messages, id: \.self) { message in
                        HStack{
                            if !message.isFromChat {
                                Spacer()
                            }
                            
                            Markdown(message.returnTextFormatted())
//                                .foregroundColor(message.isFromChat ? .red : .blue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                            
                            if message.isFromChat {
                                Spacer()
                            }
                        }
                        .glassEffect(in: RoundedRectangle(cornerRadius: 25))
                            .padding(8)
                        
                    }
                }
                .padding(.horizontal)
                .onAppear {
                    chatViewModel.scrollToBottom(scrollView: scrollView)
                }
                .onChange(of: chatViewModel.messages) {
                    chatViewModel.scrollToBottom(scrollView: scrollView)
                }
                
            }
        }
    }
}

#Preview {
    ChatbotView()
}
