//
//  CoretanSwiftui.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import SwiftUI

struct FaceShapeResult: View {
    @StateObject var vm = FaceDetectionEnvironmentObject()
    
    var body: some View {
        Text("Bentuk wajah: \(String(vm.mostFaceLabel))")
    }
}


