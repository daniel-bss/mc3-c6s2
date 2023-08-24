//
//  FaceDetectionView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import SwiftUI

struct FaceDetectionView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return FaceShapeViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
