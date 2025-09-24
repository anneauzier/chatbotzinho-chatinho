//
//  ContentView.swift
//  DAFMColorTool
//
//  Created by Danilo Altheman on 13/08/25.
//

import SwiftUI
import FoundationModels
import Playgrounds

struct PalletGeneratorView: View {
    @State private var prompt = ""
    @State private var isGenerating = false
    
    @State private var colors: [ColorModel] = []
    
    var body: some View {
        VStack {
            if isGenerating {
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Text("Generating colors...")
                        .font(.headline)
                }
            }
            List {
                ForEach(colors) { colorModel in
                    HStack {
                        Rectangle()
                            .fill(colorModel.color)
                            .frame(width: 50, height: 50)
                            .border(Color.gray, width: 1)
                        VStack(alignment: .leading) {
                            Text(verbatim: colorModel.colorName)
                                .font(.headline)
                            Text(verbatim: colorModel.hexCode)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(colorModel.rgbCode)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .padding()
            .navigationTitle("Color Palette Generator")
            .toolbar {
                ToolbarItem {
                    Button("Generate SwiftUI Extension") {
                        generateSwiftUIExtension()
                    }
                    .disabled(colors.isEmpty)
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    TextField("Ask to generate a color palette", text: $prompt)
                        .onSubmit {
                            Task {
                                await generateColors()
                            }
                        }
                    Button("Generate") {
                        Task {
                            await generateColors()
                        }
                    }
                    .disabled(isGenerating)
                    .buttonStyle(.glassProminent)
                }
                .padding()
            }
        }
    }
    
    private func generateColors() async {
        do {
            let session = LanguageModelSession(instructions: "generate five distinct colors based on prompt")
            let result = try await session.respond(to: prompt, generating: ColorPallet.self)
            
            colors = result.content.colors
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func generateSwiftUIExtension() { }
}

#Preview {
    PalletGeneratorView()
}

