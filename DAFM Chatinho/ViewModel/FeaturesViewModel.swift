//
//  FeaturesViewModel.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//

import Foundation
import Observation
import FoundationModels

@Observable
class FeaturesViewModel {
    
    var featureList:[String]
    var featureText: String
    
    let userStoriesPrompt = "Generate a product backlog following the SCRUM principles for an iOS development project, with design and coder roles, thinking on a functional iOS app as the output. The prompt in providing the apps main feature. The output must be  list of user stories based on the feature description. A feature can be break down into more than a single user story if needed. Describe tasks for this stories for both coders and designer when necessary. Each feature is separated by the '|' character in the input data."
    
    
    init() {
        featureList = []
        featureText = ""
    }
    
    func addNewFeature() {
        featureList.append(featureText)
        featureText = ""
    }
    
    func generateUserStories() async throws -> ProductBacklog {
        let featureDescriptions = createFeatureList()
        let session = LanguageModelSession(instructions: userStoriesPrompt)
        let result = try await session.respond(to: featureDescriptions,
                                               generating: ProductBacklog.self)
        return result.content
    }
    
    func createFeatureList() -> String {
        featureList
            .enumerated()
            .reduce("") { partialList, newFeature in
            partialList + pipe(newFeature.offset) + newFeature.element
        }
    }
    
    private func pipe(_ newFeatureOffset: Int) -> String {
        return newFeatureOffset != 0 ? "|"  : ""
    }

    func featureToEdit(_ feature: String) {
        featureText = feature
        featureList.removeAll(where: { $0 == feature})
    }
    
}
