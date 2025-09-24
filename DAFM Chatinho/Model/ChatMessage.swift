//
//  ChatMessage.swift
//  DAFM Chatinho
//
//  Created by Anne Auzier on 24/09/25.
//

import Foundation

struct ChatMessage: Identifiable, Equatable, Hashable{
    var id: UUID = UUID()
    var message: String
    var isFromChat: Bool
    
    private func formattedDate() -> String {
        let date = Date()
        let dateFormatter = Date.FormatStyle(date: .abbreviated, time: .standard)
 
        return date.formatted(dateFormatter)
    }
    
    func returnTextFormatted() -> String {
        return "\(formattedDate()): \n \(message)"
    }
}
