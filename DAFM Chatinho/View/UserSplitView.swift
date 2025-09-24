//
//  UserSplitView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 24/09/25.
//

import SwiftUI

struct UserSplitView: View {
    @State private var selectedItem: StoryModel = StoryModel(text: "Home")
    
    @State var items: [StoryModel] = [
        StoryModel(text: "Home"), StoryModel(text: "Sobre"), StoryModel(text: "Sobre nós"), StoryModel(text: "Sobre a equipe"), StoryModel(text: "Sobre o projeto")]
    
    var body: some View {
        
        NavigationSplitView {
            UserSideBar(items: items, selectedItem: $selectedItem)
        } detail: {
            UserDetailView(selectedItem: $selectedItem)
        }
    }
}

struct UserSideBar: View {
    @State var items: [StoryModel]
    @Binding var selectedItem: StoryModel
    
    var body: some View {
        List{
            ForEach(items, id: \.id){ item in
                Button {
                    selectedItem = item
                } label: {
                    Text(item.text)
                }
            }
        }
    }
}

struct UserDetailView: View {
    @Binding var selectedItem: StoryModel
    var body: some View {
        Text(selectedItem.text)
    }
}
