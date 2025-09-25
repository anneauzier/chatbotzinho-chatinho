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
                    Text("Create a backlog clicking on + button")
                }
            } detail: {
                UserDetailView(userStory: selectedItem)
            }
//        } else {
//            Text("Sem backlog")
//        }
//    }
//}
//
//struct ProductSideBar: View {
//    
//    var array = [1,3,4,5,6,7,8,9,10]
//    var body: some View {
//        List{
//            ForEach(array, id: \.self){ index in
//                Text("\(index)")
//            }
//        }
//    }
//}
//
//struct UserSideBar: View {
//    @State var backlog: ProductBacklog
//    @Binding var selectedStory: UserStory?
//    
//    var body: some View {
//        
//    }
//}

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



