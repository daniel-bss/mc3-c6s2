//
//  OnboardingView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("klik saya") {
                RootFaceDetectionView()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
