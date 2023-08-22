//
//  AppManager.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import Foundation

class AppManager {
    static let shared = AppManager()
    private init() {}
    
    var didShowFace: Bool = false
    var isLoading: Bool = false
    
    var frameColors: [String] = ["red", "green", "blue", "black", "pink", "gold"]
    
    var frameName: [String] = [
        "revel-black",
        "ezra-gold",
        "elm-green",
        "atlas-green",
        "intense-blue", "intense-pink",
        "equality-red", "equality-green", "equality-blue",
        "aperture-blue", "aperture-red",
    ]
    
    var labelContainer: [Int] = []
    
    
    func getModeValue(_ array: [Int]) -> Int {
        var container: [Int] = []
        var containerDict: [Int: Int] = [:]

        for value in array {
            if !container.contains(value) {
                container.append(value)
            }
        }
        
        for value in container {
            containerDict[value] = 0
        }
        
        for value in array {
            containerDict[value] = containerDict[value]! + 1
        }

        var z = containerDict.keys.first!
        for key in containerDict.keys {
            if containerDict[z]! < containerDict[key]! {
                z = key
            }
        }
        
        return z
    }

}

enum Instructions: String {
    case positionYourFace = "Position your face within the frame"
    case moveYourHead = "Hold still until the circle fills up."
    case repositionYourFace = "Reposition your face within the frame"
    case faceScanIsComplt = "Face scanning is now complete"
    case processing = "Face scanning is now complete."
}
