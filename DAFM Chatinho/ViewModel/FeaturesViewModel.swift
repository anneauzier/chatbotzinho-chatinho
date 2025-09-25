//
//  FeaturesViewModel.swift
//  DAFM Chatinho
//
//  Created by Sergio Ordine on 25/09/25.
//

import Foundation
import Observation

@Observable
class FeaturesViewModel {
    
    var featureList:[String]
    var featureText: String
    
    
    init() {
        featureList = []
        featureText = ""
    }
    
    func addNewFeature() {
        featureList.append(featureText)
        featureText = ""
    }
    
    func generateUserStories() {
        print(createFeatureList())
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
    
}
