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
    
    func returnColor() -> Color {
        switch self {
           case .coding:
            return Color.blue.opacity(0.3)
        case .design:
            return Color.purple.opacity(0.3)
        }
    }
    
    static func cretateByString(name: String) -> Role {
        switch name {
            case "coder", "coding", "developer", "Coding":
            return .coding
        case "designer", "design", "designing", "Design":
            return .design
        default:
            return .coding
        }
    }
}

enum Priority: String {
    case high = "High", mediumHigh = "Medium High", medium = "Medium", mediumLow = "Medium Low", low = "Low"
    
    func returnColor() -> Color {
        switch self {
            case .high:
            return Color.red.opacity(0.5)
        case .mediumHigh:
            return Color.orange.opacity(0.5)
        case .medium:
            return Color.pink.opacity(0.5)
        case .mediumLow:
            return Color.blue.opacity(0.5)
        case .low:
            return Color.green.opacity(0.5)
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
