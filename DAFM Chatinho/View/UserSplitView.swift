//
//  UserSplitView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 24/09/25.
//

import SwiftUI

struct UserSplitView: View {
    @State var backlog: ProductBacklog?
    @State var selectedItem: UserStory? = nil
    
    var body: some View {
        
        if let backlog = backlog {
            NavigationSplitView {
                UserSideBar(backlog: backlog, selectedStory: $selectedItem)
            } detail: {
                UserDetailView(userStory: selectedItem)
            }
        } else {
            Text("Sem backlog")
        }
    }
}

struct UserSideBar: View {
    @State var backlog: ProductBacklog
    @Binding var selectedStory: UserStory?
    
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
    var userStory: UserStory?
    var body: some View {
        VStack{
            if let selectedItem = userStory {
                Text(selectedItem.shortDescription)
            }
        }
    }
}
