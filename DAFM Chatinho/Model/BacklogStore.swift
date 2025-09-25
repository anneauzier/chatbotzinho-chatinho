//
//  BacklogStore.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//

import Foundation

@Observable
class BacklogStore {
    var backlogs:[ProductBacklog] = []
    var selectedBacklog: ProductBacklog?
}
