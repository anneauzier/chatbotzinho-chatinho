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
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(selectedItem.shortDescription)
                                .font(.largeTitle)
                        }
                        
                        Text(selectedItem.description)
                            .font(.body)
                        
                        ForEach(selectedItem.acceptanceCriteria, id: \.self){ criteria in
                            Text(criteria)
                                .font(.headline)
                        }
                        
                        ForEach(selectedItem.tasks, id: \.name) { task in
                            HStack{
                                Text(task.name)
                                    .font(.title)
                                Text(task.role)
                                    .font(.title2)
                                Text("\(task.priority)")
                                    .font(.title)
                                    .foregroundStyle(.red)
                            }
                            
                            Text(task.description)
                                .font(.body)
                        }
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .border(.red)
                    
                    
                }.padding()
                    .border(.blue)
            }
        }
    }
}
