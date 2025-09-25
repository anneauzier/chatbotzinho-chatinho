//
//  History.swift
//  POC-BacklogGenerator
//
//  Created by Igor Vicente on 24/09/25.
//

import FoundationModels
import Foundation

@Generable(description: "Scrum user story")
struct UserStory: Identifiable {
    
    var id: String {
        shortDescription
    }
    
    @Guide(description: "Short name description")
    var shortDescription: String
    
    @Guide(description: "User story description (e.g. As user, I would like to do `something`, so that I can do `Z`)")
    var description: String
    
    @Guide(description: "User story acceptance criteria (e.g. I can do `Z` if I can do `something`)")
    var acceptanceCriteria: [String]
    
    @Guide(description: "a list of tasks necessarly to match with this user story acceptance criterias")
    var tasks: [UserStoryTask]
    
    @Guide(description: "How important is this user stories for the project, focused on user's needs ( 0 - 5 : low - medium low - medium - medium high - high)")
    var priority: Int
}
