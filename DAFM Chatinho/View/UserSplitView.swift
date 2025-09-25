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
    
    var array = [1,3,4,5,6,7,8,9,10]
    var body: some View {
        List{
            ForEach(array, id: \.self){ index in
                Text("\(index)")
            }
        }
    }
}

struct UserSideBar: View {
    @State var backlog: ProductBacklog
    @Binding var selectedStory: UserStory?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("User stories")
                .font(.title2).bold()
                .padding(.leading)
            List {
                ForEach(backlog.userStories, id: \.id){ userStory in
                    Button {
                        selectedStory = userStory
                    } label: {
                        VStack(alignment: .leading) {
                            HStack{
                                Text(userStory.shortDescription)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text("\(userStory.priorityEnum.rawValue)")
                                    .font(.body)
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 6)
                                    .background {
                                        Capsule()
                                            .fill(userStory.priorityEnum.returnColor())
                                    }
                            }
                            
                            Text("\(userStory.responsable)")
                                .font(.caption)
                                
                        }
                    }
                }
            }.frame(maxWidth: .infinity)
        }
    }
}

