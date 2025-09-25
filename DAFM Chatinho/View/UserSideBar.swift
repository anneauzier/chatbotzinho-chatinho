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
