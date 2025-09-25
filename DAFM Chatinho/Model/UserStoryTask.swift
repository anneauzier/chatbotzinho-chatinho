//
//  UserStoryTask.swift
//  POC-BacklogGenerator
//
//  Created by Igor Vicente on 24/09/25.
//

import FoundationModels
import SwiftUI

enum Role {
    case coding, design
}

enum Priority: Int {
    case high = 5, mediumHigh = 4, medium = 3, mediumLow = 2, low = 1
    
    func returnColor() -> Color {
        switch self {
            case .high:
            return Color.red
        case .mediumHigh:
            return Color.orange
        case .medium:
            return Color.yellow
        case .mediumLow:
            return Color.blue
        case .low:
            return Color.green
        }
    }
    
    static func cretateByNumber(number: Int) -> Priority {
        switch number {
            case 5:
            return .high
        case 4:
            return .mediumHigh
        case 3:
            return .medium
        case 2:
            return .mediumLow
        default:
            return .low
        }
    }
}





@Generable(description: "A user storie task")
struct UserStoryTask {
    
    @Guide(description: "task name")
    var name: String
    
    @Guide(description: "task description")
    var description: String
    
    @Guide(description: "represent who will complete the task, can be either coding or design")
    var role: String
    
    @Guide(description: "how mutch time is estimated for complete this task")
    var timeEstimation: Int
    
    @Guide(description: "how important is the task related to the other user stories tasks ( 1 - 5 : low - medium low - medium - medium high - high)")
    var priority: Int
    
}

struct UserStoryTaskMock {
    
    var name: String
    
    var description: String
    
    var role: String
    
    var timeEstimation: Int
    
    var priority: Int
    
}
