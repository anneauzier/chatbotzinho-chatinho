//
//  Item.swift
//  DAFM Chatinho
//
//  Created by Danilo Altheman on 23/08/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
