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
    @State var isCreating: Bool = false
    
    var body: some View {

        if isCreating {
            NavigationSplitView {
                ProductSideBar(backlog: $backlog)
            } detail: {
                if isCreating {
                    FeatureList()
                } else {
                    UserDetailView(userStory: selectedItem)
                }
            }
        } else {
            NavigationSplitView {
                ProductSideBar(backlog: $backlog)
            } content: {
                if let backlog {
                    UserSideBar(backlog: backlog, selectedStory: $selectedItem)
                } else {
                    EmptyView()
                }
            } detail: {
                if isCreating {
                    FeatureList()
                } else {
                    UserDetailView(userStory: selectedItem)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isCreating.toggle()
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



