//
//  CoretanSwiftui.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import SwiftUI

struct FaceShapeResult: View {
    @StateObject var vm = FaceDetectionEnvironmentObject()
    @State var data: [String] = []
    @State var data2: [String] = []
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0)
                .onAppear {
                    self.data = AppManager.shared.getFrameRecommendations(faceShape: vm.faceShapeName, skinTone: vm.skinToneName)
                    self.data2 = AppManager.shared.getFrameRecommendations2(faceShape: vm.faceShapeName, skinTone: vm.skinToneName)
        //            print(self.data)
                }
            VStack {
                Text("Bentuk wajah: \(String(vm.faceShapeName))")
                Text("Skin tone: \(String(vm.skinToneName))")
                Text("UNTUK ASSET:")
                ForEach(data, id: \.self) { nilai in
                    Text(nilai)
                }
                Text("=======")
                Text("ALL COMBINATION")
                ForEach(data2, id: \.self) { nilai in
                    Text(nilai)
                }
            }
        }
        
    }
}


