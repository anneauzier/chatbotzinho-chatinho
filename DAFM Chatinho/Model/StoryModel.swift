//
//  StoryModel.swift
//  DAFM Chatinho
//
//  Created by Filipe Lopes on 24/09/25.
//

import Foundation
import FoundationModels

@Generable(description: "Sei la")
struct StoryModel: Identifiable {
    var id: String { text }
    
    @Guide(description: "Sei la")
    var text: String
}
