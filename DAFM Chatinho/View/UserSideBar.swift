//
//  UserSideBar.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//

import SwiftUI

struct UserSideBar: View {
    var backlog: ProductBacklog
    @Binding var selectedStory: UserStory?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("User stories")
                .font(.title2).bold()
                .padding([.top,.horizontal])
            
            Text("\(backlog.userStories.count) stories  -  \(0) completed")
                .padding([.bottom,.horizontal])
            
            Divider()
            
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
            }
        }
    }
}
