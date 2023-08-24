//
//  RootFaceDetectionView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import SwiftUI

struct RootFaceDetectionView: View {
//    @ObservedObject var vm = FaceDetectionEnvironmentObject()
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect().eraseToAnyPublisher()
    @State var isLoading = false
    @State var isPresented = false
    var body: some View {
        ZStack {
            FaceDetectionView()
                .ignoresSafeArea()
            if !isLoading {
                CameraTextOverlayView()
            } else {
                LoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            self.isPresented = true
                        })
                        
                    }
            }
        }
        .navigationDestination(isPresented: $isPresented, destination: {
//            FaceShapeResult() // coretan
            ARMainView()
                .navigationBarBackButtonHidden(true)
        })
        .onReceive(timer) { _ in
            self.isLoading = AppManager.shared.isLoading
        }
    }
}
