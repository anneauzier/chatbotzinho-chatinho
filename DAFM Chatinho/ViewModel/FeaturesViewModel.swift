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
    
}
