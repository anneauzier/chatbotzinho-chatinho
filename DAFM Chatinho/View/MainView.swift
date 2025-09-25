//
//  MainView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 24/09/25.
//

import SwiftUI
import FoundationModels

enum MenuOptions: String, CaseIterable {
    case chatBot = "Chat Bot"
    case palletGenerator = "Pallet Generator"
    case scrum = "Scrum"
}

struct MainView: View {
    @State var selected: MenuOptions = .scrum
    
    var body: some View {
        switch SystemLanguageModel.default.availability {
        case .available:
            VStack {
                HStack {
                    ForEach(MenuOptions.allCases, id: \.self){ option in
                        Button(action: {
                            self.selected = option
                        }) {
                            Text(option.rawValue)
                                .foregroundStyle(selected == option ? .white : .black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(selected == option ? .blue : .gray)
                                )
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                    }
                }
                switch selected {
                case .chatBot:
                    ChatbotView()
                case .scrum:
                    FeatureList()
                case .palletGenerator:
                    PalletGeneratorView()
                }
            }
        case .unavailable:
            Text("Liga o Apple Inteligence ai faz favor meu amigo!")
        }
        
    }
}
