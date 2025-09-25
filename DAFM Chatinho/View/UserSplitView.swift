//
//  UserSplitView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 24/09/25.
//

import SwiftUI

struct UserSplitView: View {
    @State var backlog: ProductBacklog
    
    var body: some View {
        
        NavigationSplitView {
            UserSideBar(items: items, selectedItem: $selectedItem)
        } detail: {
            UserDetailView(selectedItem: $selectedItem)
        }
    }
}

struct UserSideBar: View {
    @State var backlog: ProductBacklog
    @Binding var selectedStory: UserStory
    
    var body: some View {
        List{
            ForEach(backlog.userStories, id: \.id){ userStory in
                Button {
                    selectedStory = userStory
                } label: {
                    Text(userStory.shortDescription)
                }
            }
        }
    }
}

struct UserDetailView: View {
    @State var userStory: UserStory
    var body: some View {
        VStack{
            Text(selectedItem.text)
        }
    }
}
