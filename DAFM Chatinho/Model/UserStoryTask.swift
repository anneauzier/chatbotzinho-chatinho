//
//  UserStoryTask.swift
//  POC-BacklogGenerator
//
//  Created by Igor Vicente on 24/09/25.
//

import FoundationModels

enum Role {
    case coding, design
}

enum Priority: Int {
    case high = 1, mediumHigh, medium, mediumLow, low
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
    
    @Guide(description: "how important is the task related to the other user stories tasks ( 0 - 5 : low - medium low - medium - medium high - high)")
    var priority: Int
    
}
