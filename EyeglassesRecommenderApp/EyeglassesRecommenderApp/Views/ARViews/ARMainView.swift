//
//  ARMainView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 23/08/23.
//

import SwiftUI

struct ARMainView: View {
    @StateObject var vm = FaceDetectionEnvironmentObject()
    
    @State var frameAsset: String = "round-light-pink"
    @State var frameAssetBefore: String = "square-medium-pink"
    @State var frameAssets: [String] = []
    
    let width: Double = 56 * 1.5 // = 84
    
    var body: some View {
        ZStack {
            Color.clear
                .onAppear {
                    self.frameAssets = AppManager.shared.getFrameRecommendations(faceShape: vm.faceShapeName, skinTone: vm.skinToneName)
                    self.frameAsset = self.frameAssets[0]
                    self.frameAssetBefore = self.frameAssets[0]
                }
            
            ARViewContainer(frameAsset: $frameAsset, frameAssetBefore: $frameAssetBefore)
                .ignoresSafeArea()
            
//            Color.black.opacity(0.2)
//                .ignoresSafeArea()
//                .onAppear {
//                    self.frameAssets = AppManager.shared.getFrameRecommendations(faceShape: vm.faceShapeName, skinTone: vm.skinToneName)
//                }
            
            HStack {
                ForEach(self.frameAssets, id: \.self) { frameImageName in
//                    Circle()
//                        .fill(.white)
//                        .overlay(GeometryReader {
//                            let side = sqrt($0.size.width * $0.size.width)
//                            VStack {
//                                Rectangle().foregroundColor(.clear)
//                                    .frame(width: side, height: side)
//                                    .overlay(
//                                        Image(frameImageName)
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                    )
//                            }
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        })
//                        .frame(width: width, height: width)
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.red)
                        .onTapGesture {
                            print(frameImageName)
                            self.frameAssetBefore = self.frameAsset
                            self.frameAsset = frameImageName
                        }
                            
                            
                }
//                Circle()
//                    .frame(width: 100, height: 100)
//                    .foregroundColor(.red)
//                    .onTapGesture {
//                        self.frameAssetBefore = self.frameAsset
//                        self.frameAsset = AppManager.shared.satu
//                    }
//
//                Circle()
//                    .frame(width: 100, height: 100)
//                    .foregroundColor(.blue)
//                    .onTapGesture {
//                        self.frameAssetBefore = self.frameAsset
//                        self.frameAsset = AppManager.shared.dua
//                    }
                
            }
            .offset(y: 300)
        }
            
    }
    
}

//struct ARMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARMainView()
//    }
//}




/*
 
 
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
 
 */
