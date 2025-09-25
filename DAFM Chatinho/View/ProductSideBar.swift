//
//  ProductSideBar.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//


import SwiftUI

struct ProductSideBar: View {
    //    @State var backlog: ProductBacklogMock
    @Environment(BacklogStore.self) var backlogStore
    
    var body: some View {
        List{
            ForEach(backlogStore.backlogs){ backlog in
                Button {
                    print("Changing to \(backlog)")
                    self.backlogStore.selectedBacklog = backlog
                } label: { Text("\(backlog.name)") }
            }
        }
    }
}
