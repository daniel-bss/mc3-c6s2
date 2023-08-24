//
//  ARViewContainer.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 24/08/23.
//

import SwiftUI
import RealityKit
import ARKit
import Foundation

struct ARViewContainer: UIViewRepresentable {
    @Binding var didRestart: Bool
    @Binding var frameAsset: String
    @Binding var frameAssetBefore: String
//    @State var modelEntity: ModelEntity = ModelEntity()
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let newConfig = ARFaceTrackingConfiguration()
        let faceAnchor = AnchorEntity(.face)
        arView.scene.anchors.append(faceAnchor)
        arView.session.run(newConfig, options: [.resetTracking, .removeExistingAnchors, .stopTrackedRaycasts, .resetSceneReconstruction])
        
        switch frameAsset {
            case "oval-medium-blue" :
                arView.scene.anchors.append(try! Experience.loadApertureGlassesOvalBlue())
            case "square-medium-blue" :
                arView.scene.anchors.append(try! Experience.loadIntenseGlassesSquareBlue())
            case "square-medium-pink" :
                arView.scene.anchors.append(try! Experience.loadIntenseGlassesSquarePink())
            case "oval-light-pink" :
                arView.scene.anchors.append(try! Experience.loadAtlasOvalPink())
            case "round-medium-green" :
                arView.scene.anchors.append(try! Experience.loadAtlasRoundGreen())
            case "round-light-pink" :
                arView.scene.anchors.append(try! Experience.loadEzraRoundPink())
            case "rectangle-dark-blue" :
                arView.scene.anchors.append(try!    Experience.loadEqualityGlassesRectabgleBlue())
            case "rectangle-light-pink" :
                arView.scene.anchors.append(try!    Experience.loadEqualityGlassesRectanglePink())
            case "rectangle-medium-green" :
                arView.scene.anchors.append(try!    Experience.loadEqualityGlassesRectangleGreen())
            case "aviator-light-gray" :
                arView.scene.anchors.append(try!    Experience.loadRevelGlassesAviatorGGray())
            case "cateye-dark-green" :
                arView.scene.anchors.append(try!    Experience.loadElmGlassesCatEyeGreen())
            default:
                arView.scene.anchors.append(try! Experience.loadNoFrames())
        }
        
        return arView
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {
            
            uiView.scene.anchors.removeAll()
            
            switch frameAsset {
            case "oval-medium-blue" :
                uiView.scene.anchors.append(try! Experience.loadApertureGlassesOvalBlue())
            case "square-medium-blue" :
                uiView.scene.anchors.append(try! Experience.loadIntenseGlassesSquareBlue())
            case "square-medium-pink" :
                uiView.scene.anchors.append(try! Experience.loadIntenseGlassesSquarePink())
            case "oval-light-pink" :
                uiView.scene.anchors.append(try! Experience.loadAtlasOvalPink())
            case "round-medium-green" :
                uiView.scene.anchors.append(try! Experience.loadAtlasRoundGreen())
            case "round-light-pink" :
                uiView.scene.anchors.append(try! Experience.loadEzraRoundPink())
            case "rectangle-dark-blue" :
                uiView.scene.anchors.append(try!    Experience.loadEqualityGlassesRectabgleBlue())
            case "rectangle-light-pink" :
                uiView.scene.anchors.append(try!    Experience.loadEqualityGlassesRectanglePink())
            case "rectangle-medium-green" :
                uiView.scene.anchors.append(try!    Experience.loadEqualityGlassesRectangleGreen())
            case "aviator-light-gray" :
                uiView.scene.anchors.append(try!    Experience.loadRevelGlassesAviatorGGray())
            case "cateye-dark-green" :
                uiView.scene.anchors.append(try!    Experience.loadElmGlassesCatEyeGreen())
            default:
                uiView.scene.anchors.append(try! Experience.loadNoFrames())
            }
        
    }
    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: ARViewContainer
//        var previousNameAR: String = ""
//
//        init(_ parent: ARViewContainer) {
//            self.parent = parent
//        }
//    }
}
