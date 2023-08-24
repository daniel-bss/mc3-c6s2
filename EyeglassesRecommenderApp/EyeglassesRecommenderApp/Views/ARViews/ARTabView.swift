//
//  ARCoretanView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 23/08/23.
//

import SwiftUI

struct ARTabView: View {
    var body: some View {
        TabView {
            ARMainView()
                .tabItem {
                    Label("Anjay", systemImage: "list.dash")
                }
            Text("Mantap")
                .tabItem {
                    Label("Anjuuy", systemImage: "list.dash")
                }
        }
        .ignoresSafeArea()
    }
}

struct ARTabView_Previews: PreviewProvider {
    static var previews: some View {
        ARTabView()
    }
}
