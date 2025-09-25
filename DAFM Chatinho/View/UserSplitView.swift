//
//  UserSplitView.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 24/09/25.
//

import SwiftUI

struct UserSplitView: View {
    
    @Environment(BacklogStore.self) var backlogStore
    
    @State var selectedItem: UserStory? = nil
    @State var isCreating: Bool = false
    
    var body: some View {

        if isCreating {
            NavigationSplitView {
                ProductSideBar()
            } detail: {
                FeatureList(isCreating: $isCreating)
            }
        } else {
            NavigationSplitView {
                ProductSideBar()
            } content: {
                if let backlog = backlogStore.selectedBacklog {
                    UserSideBar(backlog: backlog,
                                selectedStory: $selectedItem)
                } else {
                    EmptyView()
                }
            } detail: {
                UserDetailView(userStory: selectedItem)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isCreating = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    NavigationStack {
        UserSplitView()
    }
}



