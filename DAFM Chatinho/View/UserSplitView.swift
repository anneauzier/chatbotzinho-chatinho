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
                ProductSideBar()
            } content: {
                UserSideBar(backlog: backlog, selectedStory: $selectedItem)
            } detail: {
                UserDetailView(userStory: selectedItem)
            }
        } else {
            Text("Sem backlog")
        }
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
                    VStack(alignment: .leading, spacing: 30) {
                        
                        HStack {
                            Text(selectedItem.shortDescription)
                                .font(.largeTitle)
                                .bold()
                        }
                
                        Text(selectedItem.description)
                            .font(.body)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Acceptance Criteria")
                                .font(.title2)
                                .bold()
                            
                            ForEach(selectedItem.acceptanceCriteria, id: \.self) { item in
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                        .imageScale(.medium)
                                    Text(item)
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }.cardStyle
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Tasks")
                                .font(.title2)
                                .bold()

                            ForEach(selectedItem.tasks, id: \.name) { task in
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(task.name)
                                        .font(.title2)
                                    Text(task.description)
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    Text(task.role)
                                        .font(.body)

                                }
                            }
                        }.cardStyle
                    }
                }.padding()
            }
        }
    }
}

extension View {
    var cardStyle: some View {
        self
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(.secondarySystemFill))
            )
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}
