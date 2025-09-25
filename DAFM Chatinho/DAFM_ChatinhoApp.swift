//
//  DAFM_ChatinhoApp.swift
//  DAFM Chatinho
//
//  Created by Danilo Altheman on 23/08/25.
//

import SwiftUI

@main
struct DAFM_ChatinhoApp: App {
    
    @State var backlogStore: BacklogStore = BacklogStore()

    var body: some Scene {
        WindowGroup {
//            ChatbotView()
           // MainView()
            NavigationStack {
                UserSplitView()
                    .environment(backlogStore)
            }
        }
    }
    
    init() {
        backlogStore.backlogs.append(ProductBacklog(name: "Test 1", userStories: [ UserStory(shortDescription: "aaa", description: "bleblebe", acceptanceCriteria: [], tasks: [], priority: 0)]))
        backlogStore.backlogs.append(ProductBacklog(name: "Test 2", userStories: [ UserStory(shortDescription: "bbb", description: "bleblebe", acceptanceCriteria: [], tasks: [], priority: 0)]))
    }
}
