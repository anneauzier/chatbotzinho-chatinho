//
//  ProductBacklog.swift
//  POC-BacklogGenerator
//
//  Created by Igor Vicente on 24/09/25.
//

import FoundationModels
import Foundation

@Generable(description: "A representation of a product backlog for scrum methodology")
struct ProductBacklog: Identifiable {
    
    var id: String {
        name
    }
    
    var name:String
    
    @Guide(description: "A list of user stories that compose the product backlog and have to be completed so that the project can be considered done")
    var userStories: [UserStory]
}

struct ProductBacklogMock {
        var userStories: [UserStoryMock] = []
}

let example = ProductBacklogMock(userStories:[
    UserStoryMock(shortDescription: "User 1",
                  description: "User story 1",
                  acceptanceCriteria: ["Sei la 1", "sei la 2", "sei la 3"],
                  tasks: [
                    UserStoryTaskMock(name: "Task 1 U1", description: "Task 1 User story1", role: "Coder", timeEstimation: 1, priority: 1),
                    UserStoryTaskMock(name: "Task 2 U1", description: "Task 2 User story1", role: "Designer", timeEstimation: 2, priority: 2),
                  ],
                  priority: 1),
    UserStoryMock(shortDescription: "User 2",
                  description: "User story 2",
                  acceptanceCriteria: ["Sei la 1", "sei la 2", "sei la 3"],
                  tasks: [
                    UserStoryTaskMock(name: "Task 1 U2", description: "Task 1 User story2", role: "Coder", timeEstimation: 1, priority: 1),
                    UserStoryTaskMock(name: "Task 2 U2", description: "Task 2 User story2", role: "Designer", timeEstimation: 2, priority: 2),
                  ],
                  priority: 1),
    
])
