//
//  MainView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 24/09/25.
//

import SwiftUI

struct MainView: View {
    @State var selected: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.selected.toggle()
                }) {
                    Text("Change")
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
            }
            
            if selected {
                ScrumView()
            } else {
                ChatbotView()
//                PalletGeneratorView()
            }
        }
        
    }
}
