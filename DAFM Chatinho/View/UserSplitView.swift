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
                ProductSideBar()
            } detail: {
                if isCreating {
                    FeatureList()
                } else {
                    UserDetailView(userStory: selectedItem)
                }
            }
        } else {
            NavigationSplitView {
                ProductSideBar()
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

struct ProductSideBar: View {
    //    @State var backlog: ProductBacklogMock
    //    @Binding var selectedStory: UserStoryMock?
    
    var array = [1,3,4,5,6,7,8,9,10]
    var body: some View {
        List{
            ForEach(array, id: \.self){ index in
                Text("\(index)")
                //                Button {
                //                    selectedStory = userStory
                //                } label: {
                //                    Text(userStory.shortDescription)
                //                }
            }
        }
    }
}

