//
//  FaceDetectionEnvironmentObject.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import SwiftUI

class FaceDetectionEnvironmentObject: ObservableObject {
    @Published var didShowFace: Bool = false
    @Published var didScanComplete: Bool = false
    
    @Published var mostFaceLabel: Int = 990
    @Published var mostSkinToneLabel: Int = 991
    
    @Published var faceShapeName: String = ""
    @Published var skinToneName: String = ""
    
    let faceShapeLabels: [String] = ["heart", "oblong", "oval", "round", "square"]
//    let skinToneLabels: [String] = ["olive", "white", "dark"] // olive: 0, white: 1, dark: 2
    let skinToneLabels: [String] = ["medium", "light", "dark"] // olive: 0, white: 1, dark: 2
    
    init() {
        self.mostFaceLabel = AppManager.shared.getModeValue(AppManager.shared.faceLabelContainer)
        self.mostSkinToneLabel = AppManager.shared.getModeValue(AppManager.shared.skinToneLabelContainer)
        
        self.faceShapeName = self.faceShapeLabels[self.mostFaceLabel]
        self.skinToneName = self.skinToneLabels[self.mostSkinToneLabel]
    }
}
