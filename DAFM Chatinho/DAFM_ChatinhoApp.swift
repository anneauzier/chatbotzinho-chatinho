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
            NavigationStack {
                UserSplitView()
                    .environment(backlogStore)
            }
        }
    }
}
