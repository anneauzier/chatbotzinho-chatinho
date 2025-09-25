//
//  ProductSideBar.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//


import SwiftUI

struct ProductSideBar: View {
    //    @State var backlog: ProductBacklogMock
    @Binding var backlog: ProductBacklog?
    @Environment(BacklogStore.self) var backlogStore
    
    var array = [1,3,4,5,6,7,8,9,10]
    var body: some View {
        List{
            ForEach(backlogStore.backlogs){ index in
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
