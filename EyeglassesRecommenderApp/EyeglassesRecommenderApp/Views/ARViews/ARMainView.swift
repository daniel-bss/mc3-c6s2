//
//  ARMainView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 23/08/23.
//

import SwiftUI

struct ARMainView: View {
    @StateObject var vm = FaceDetectionEnvironmentObject()
    @State var isPresented: Bool = false
    @State var didRestartARView: Bool = false
    
//    @State var frameAsset: String = "oval-medium-blue"
//    @State var frameAssetBefore: String = "oval-medium-blue"
//    @State var frameAssets: [String] = []
    
    @State var frameAssets: [String] = []
    @State var frameAsset: String = ""
    @State var frameAssetBefore: String = ""
    
    @State var sheetIsPresented: Bool = false
    
    @State var stringOfFramesArray: [String] = []
    
    @State var stringOfFrames: String = ""
    @State var stringOfSkinTones: String = ""
    
    let width: Double = 56 * 1.5 // = 84
    
    var body: some View {
        ZStack {
            Color.clear
                .onAppear {
                    self.frameAssets = AppManager.shared.getFrameRecommendations(faceShape: vm.faceShapeName, skinTone: vm.skinToneName)
                    if self.frameAssets.count == 0 {
                        print("FRAME ASSETS = 0")
                        self.frameAssets = AppManager.shared.getFrameRecommendations2(faceShape: vm.faceShapeName, skinTone: vm.skinToneName)
                    }
                    self.frameAsset = self.frameAssets[0]
                    self.frameAssetBefore = self.frameAssets[0]
                }
            
            ARViewContainer(didRestart: $didRestartARView, frameAsset: $frameAsset, frameAssetBefore: $frameAssetBefore)
                .ignoresSafeArea()
                .onDisappear {
                    self.didRestartARView = true
                    print(self.didRestartARView)
                }
            
//            Color.black.opacity(0.2)
//                .ignoresSafeArea()
//                .onAppear {
//                    self.frameAssets = AppManager.shared.getFrameRecommendations(faceShape: vm.faceShapeName, skinTone: vm.skinToneName)
//                }
            Button {
                self.sheetIsPresented.toggle()
            } label: {
                FindOutWhyView()
            }
            .sheet(isPresented: $sheetIsPresented) {
//                Text("Based on our scanning you have a **\(frameAsset.split(separator: "-")[0])** and **\(frameAsset.split(separator: "-")[1]) Skin Tone**. So, your face suitable with eyeglasses that are **\(Cat Eye Frame)** and **\(Bright)** Color.")
                HStack {
                    Text("Your Face Scan Analysis")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                        .offset(y: -22.5)
                    Spacer()
                    ZStack {
                        Circle()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color(red: 222/255.0, green: 222/255.0, blue: 222/255.0))
                        Image(systemName: "xmark")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 133/255.0, green: 133/255.0, blue: 133/255.0))
                    }
                    .offset(x: -15, y: -20)
                    .onTapGesture {
                        self.sheetIsPresented = false
                    }
                }
                Text("Based on our scanning you have **\(vm.faceShapeName.capitalized) Face Shape** and **\(vm.skinToneName.capitalized) Skin Tone**. So, your face is suitable with **\(stringOfFrames) Frames**, and **colors of \(stringOfSkinTones)**")
                    .presentationDetents([.height(200), .medium, .large])
                    .multilineTextAlignment(.leading)
                    .presentationDragIndicator(.automatic)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .offset(x: -4)
            }
            .onAppear {
                self.stringOfFramesArray = AppManager.shared.getFrameRecommendations(faceShape: vm.faceShapeName, skinTone: vm.skinToneName)
                
                var setOfStringOfFramesArray: Set<String> = [] // frame
                var setOfStringOfFramesArray2: Set<String> = [] // skintone
                
                var tempStringOfFramesArray: Array<String> = [] // frame
                var tempStringOfFramesArray2: Array<String> = [] // skintone
                
                for fullString in stringOfFramesArray {
                    tempStringOfFramesArray.append(String(fullString.split(separator: "-")[0]))
                    tempStringOfFramesArray2.append(String(fullString.split(separator: "-")[2]))
                }
                
                // update to set himpunan
                setOfStringOfFramesArray = Set(tempStringOfFramesArray)
                setOfStringOfFramesArray2 = Set(tempStringOfFramesArray2)
                
                var temp = ""
                var i = 0
                for setOfString in setOfStringOfFramesArray {
                    if i != (setOfStringOfFramesArray.count - 1) {
                        temp += "\(setOfString.capitalized)" + ", "
                    } else {
                        if i == 0 {
                            temp = "\(setOfString.capitalized)"
                        } else {
                            let temp2 = "and " + "\(setOfString.capitalized)"
                            
                            if let index = temp.index(temp.startIndex, offsetBy: temp.count - 2, limitedBy: temp.endIndex) {
                                temp.remove(at: index)
                            }
                            
                            temp += temp2
                        }
                        
                    }
                    
                    i += 1
                }
                
                var tempx = ""
                i = 0
                for setOfString in setOfStringOfFramesArray2 {
                    if i != (setOfStringOfFramesArray2.count - 1) {
                        tempx += "\(setOfString.capitalized)" + ", "
                    } else {
                        if i == 0 {
                            tempx = "\(setOfString.capitalized)"
                        } else {
                            
                            let temp2 = "and " + "\(setOfString.capitalized)"
                            
                            if let index = tempx.index(tempx.startIndex, offsetBy: tempx.count - 2, limitedBy: tempx.endIndex) {
                                tempx.remove(at: index)
                            }
                            tempx += temp2
                        }

                    }
                    

                    i += 1
                }
                
                self.stringOfFrames = temp
                self.stringOfSkinTones = tempx
            }
            .offset(x: 120, y: -340)
            
            HStack {
                ForEach(self.frameAssets, id: \.self) { frameImageName in
                    Circle()
                        .fill(.white)
                        .overlay(GeometryReader {
                            let side = sqrt($0.size.width * $0.size.width)
                            VStack {
                                Rectangle().foregroundColor(.clear)
                                    .frame(width: side, height: side)
                                    .overlay(
                                        Image("\(frameImageName)-img")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    )
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        })
                        .frame(width: width, height: width)
                        .padding(.trailing, 20)
                        .onTapGesture {
                            print(frameImageName)
                            self.frameAssetBefore = self.frameAsset
                            self.frameAsset = frameImageName
                        }
                }
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
