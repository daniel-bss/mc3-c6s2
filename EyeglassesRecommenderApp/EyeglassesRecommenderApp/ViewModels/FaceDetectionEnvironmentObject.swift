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
    @Published var mostFaceLabel: Int = 999
    
    init() {
        self.mostFaceLabel = AppManager.shared.getModeValue(AppManager.shared.labelContainer)
    }
}
