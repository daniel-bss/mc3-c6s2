//
//  RootFaceDetectionView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import SwiftUI

struct RootFaceDetectionView: View {
    var body: some View {
        ZStack {
            FaceDetectionView()
                .ignoresSafeArea()
            CameraTextOverlayView()
        }
    }
}
