//
//  ARMainView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 23/08/23.
//

import SwiftUI

struct ARMainView: View {
    @State var xOffset: Double = 0
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
//            HStack {
//                Rectangle()
//                    .frame(width: 50, height: 50)
//                    .foregroundColor(.red)
//                    .padding(.leading, 16)
//
//                HStack {
//                    ForEach(AppManager.shared.frameName, id: \.self) { imageName in
//                        ARCircleView(imageName: imageName)
//                    }
//                }
//                .padding(.leading, 45)
//            }
//            .offset(y: 300)
            ZStack {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
                    .offset(x: -180)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(AppManager.shared.frameName[0..<7].indices, id: \.self) { index in
                            ARCircleView(index: index, xOffset: $xOffset)
                        }
                        
                    }
                }
                .padding(.leading, 56*1.5)
            }
//            .padding(.leading, 45)
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct ARMainView_Previews: PreviewProvider {
    static var previews: some View {
        ARMainView()
    }
}
