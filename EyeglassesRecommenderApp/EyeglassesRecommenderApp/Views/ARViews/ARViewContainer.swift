//
//  ARViewContainer.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 24/08/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var frameAsset: String
    @Binding var frameAssetBefore: String
//    @State var modelEntity: ModelEntity = ModelEntity()
    let faceAnchor = AnchorEntity(.face)
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        
        guard let modelEntity = try? Entity.loadModel(named: frameAsset) else { return ARView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)) }
        modelEntity.name = frameAsset
        
        faceAnchor.addChild(modelEntity)
        
        arView.scene.anchors.append(faceAnchor)
        
        let newConfig = ARFaceTrackingConfiguration()
        arView.session.run(newConfig)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        let entities = uiView.scene.anchors[0].children
        
        if entities.count > 0 {
            for entity in entities {
                if entity.name == frameAssetBefore {
                    entity.removeFromParent()
                }
            }
        }
        
        guard let modelEntity2 = try? Entity.loadModel(named: frameAsset) else { return }
        modelEntity2.name = frameAsset
        faceAnchor.addChild(modelEntity2)
    }
    
}
