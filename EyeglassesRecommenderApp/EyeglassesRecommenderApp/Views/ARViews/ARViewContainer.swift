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
    @Binding var frameAsset: String
    @Binding var frameAssetBefore: String
//    @State var modelEntity: ModelEntity = ModelEntity()
    let faceAnchor = AnchorEntity(.face)
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        guard let modelEntity = try? Entity.loadModel(named: frameAsset) else { return ARView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)) }
        modelEntity.name = frameAsset
        modelEntity.transform.rotation = simd_quatf(angle: Float(90 * Double.pi / 180.0), axis: SIMD3<Float>(0, 1, 0))
        
        arView.scene.anchors.append(faceAnchor)
        faceAnchor.addChild(modelEntity)
        
        let newConfig = ARFaceTrackingConfiguration()
        newConfig.isLightEstimationEnabled = true
        arView.session.run(newConfig, options: [.resetTracking, .removeExistingAnchors])
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
                print("AR not found")
        }

        return arView
    }
    
//    func makeUIView(context: Context) -> ARView {
//        let arView = ARView(frame: .zero)
//
//        guard let modelEntity = try? Entity.loadModel(named: frameAsset) else { return ARView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)) }
//        modelEntity.name = frameAsset
//        modelEntity.transform.rotation = simd_quatf(angle: Float(90 * Double.pi / 180.0), axis: SIMD3<Float>(0, 1, 0))
//
//        arView.scene.anchors.append(faceAnchor)
//        faceAnchor.addChild(modelEntity)
//
//        let newConfig = ARFaceTrackingConfiguration()
//        config.isLightEstimationEnabled = true
//        arView.session.run(newConfig, options: [.resetTracking, .removeExistingAnchors])
//
//        return arView
//    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if frameAssetBefore != frameAsset {
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
                    print("AR not found")
            }
        }
        
    }
//    func updateUIView(_ uiView: ARView, context: Context) {
//        let entities = uiView.scene.anchors[0].children
//        print("anchor:", uiView.scene.anchors.count)
//        if entities.count > 0 {
//            print("masuk")
//            for entity in entities {
//                if entity.name == frameAssetBefore {
//                    entity.removeFromParent()
//                }
//            }
//        }
//
//        guard let modelEntity2 = try? Entity.loadModel(named: frameAsset) else { return }
//        modelEntity2.name = frameAsset
//        faceAnchor.addChild(modelEntity2)
//    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
        
    class Coordinator: NSObject {
        var parent: ARViewContainer
        var previousNameAR: String = ""
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
    }
    
}
