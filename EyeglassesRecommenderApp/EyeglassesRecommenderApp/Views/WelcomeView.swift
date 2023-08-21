//
//  WelcomeView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 21/08/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("klik kami") {
                FaceShapeView()
                    .ignoresSafeArea()
            }
            .navigationTitle("SUPERRR")
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
