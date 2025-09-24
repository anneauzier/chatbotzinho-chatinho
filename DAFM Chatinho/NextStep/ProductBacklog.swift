//
//  ProductBacklog.swift
//  POC-BacklogGenerator
//
//  Created by Igor Vicente on 24/09/25.
//

import FoundationModels

@Generable(description: "A representation of a product backlog for scrum methodology")
struct ProductBacklog {
    
    @Guide(description: "A list of user stories that compose the product backlog and have to be completed so that the project can be considered done")
    var userStories: [UserStory]
}
