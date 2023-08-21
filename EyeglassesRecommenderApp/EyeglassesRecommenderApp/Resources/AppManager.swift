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
     
    static let positionYourFace = "Position your face within the frame"
    static let moveYourHead = "Move your head slowly to complete the circle"
    static let repositionYourFace = "Reposition your face within the frame"
    static let faceScanIsComplt = "Face scanning is now complete"
    
    var didShowFace: Bool = false
}
