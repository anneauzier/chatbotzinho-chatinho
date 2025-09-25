//
//  DAFM_ChatinhoApp.swift
//  DAFM Chatinho
//
//  Created by Danilo Altheman on 23/08/25.
//

import SwiftUI

@main
struct DAFM_ChatinhoApp: App {
    
    @State var backlog: ProductBacklog?

    var body: some Scene {
        WindowGroup {
//            ChatbotView()
           // MainView()
            NavigationStack {
                UserSplitView(backlog: backlog)
            }
        }
    }
}
