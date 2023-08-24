//
//  FaceShapeViewController.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 21/08/23.
//

import Vision
import AVFoundation
import UIKit
import SwiftUI

class FaceShapeViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview = AVCaptureVideoPreviewLayer(session: self.captureSession)
        preview.videoGravity = .resizeAspectFill
        return preview
    }()
    
    private let videoOutput = AVCaptureVideoDataOutput()
    
    // Vision parts
    private var requests = [VNRequest]()
    private var requests2 = [VNRequest]()
    
    // Face landmarks
    private var drawings: [CAShapeLayer] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addCameraInput()
        self.addPreviewLayer()
        self.addVideoOutput()
        
        self.setupVision()
        
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = self.view.bounds
    }
    
    private func addCameraInput() {

        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera],
            mediaType: .video,
            position: .front).devices.first else {
               fatalError("camera anda sepertinya meleduk")
        }
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
    }
    
    private func addPreviewLayer() {
        self.view.layer.addSublayer(self.previewLayer)
        
    }
    
    private func addVideoOutput() {
        self.videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        self.videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "my.image.handling.queue"))
        self.captureSession.addOutput(self.videoOutput)
    }

    // delegate function
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
//            return
//        }
//        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
//
//        do {
//            print("anjay1")
//            try imageRequestHandler.perform(self.requests)
//            print("anjay2\n")
//        } catch {
//            print(error)
//        }
//    }
    
    @discardableResult
    func setupVision() -> NSError? {
        // Setup Vision parts
        let error: NSError! = nil
        
        // ML MODEL!
//        guard let modelURL = Bundle.main.url(forResource: "FaceShape", withExtension: "mlmodelc") else {
        guard let modelURL = Bundle.main.url(forResource: "FaceShapeModel", withExtension: "mlmodelc") else {
            return NSError(domain: "FaceShapeViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file (FACE SHAPE) is missing"])
        }
        
        guard let modelURL2 = Bundle.main.url(forResource: "SkinToneModel", withExtension: "mlmodelc") else {
            return NSError(domain: "FaceShapeViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file (SKIN TONE) is missing"])
        }
        
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
            let skintToneModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL2))
            
            let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
                DispatchQueue.main.async(execute: {
                    // perform all the UI updates on the main queue
                    guard let results = request.results, results.count > 0 else { return }
                    let result = results[0] as! VNCoreMLFeatureValueObservation
                    guard let resultArray = result.featureValue.multiArrayValue else {return}
                    
                    var resultContainer: [Double] = []
                    for i in 0...4 { // 5 label
                        resultContainer.append(Double(resultArray[i]))
                    }
                    
//                    print("\nFACE SHAPE")
//                    print(resultContainer)
                    
                    AppManager.shared.faceLabelContainer.append(self.getIndex(resultContainer))

                })
            })
            
            let skinToneRecognition = VNCoreMLRequest(model: skintToneModel, completionHandler: { (request, error) in
                DispatchQueue.main.async(execute: {
                    // perform all the UI updates on the main queue
                    guard let results = request.results, results.count > 0 else { return }
                    let result = results[0] as! VNCoreMLFeatureValueObservation
                    guard let resultArray = result.featureValue.multiArrayValue else {return}
                    
                    var resultContainer: [Double] = []
                    for i in 0...2 { // 3 label
                        resultContainer.append(Double(resultArray[i]))
                    }
                    
//                    print("\nSKIN TONE")
//                    print(resultContainer)
                    
                    AppManager.shared.skinToneLabelContainer.append(self.getIndex(resultContainer))
                })
            })
            
            self.requests = [objectRecognition]
            self.requests2 = [skinToneRecognition]
            
        } catch let error as NSError {
            print("Model loading went wrong: \(error)")
        }
        
        return error
    }
    
    // ============================================================
    
    func getIndex(_ array: [Double]) -> Int {
        var z = array[0]
        var idx = 0
        for i in 0..<array.count {
            if z < array[i] {
                z = array[i]
                idx = i
            }
        }
        
        return idx
    }
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        self.detectFace(in: frame)
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: frame, options: [:])

        do {
            try imageRequestHandler.perform(self.requests)
            try imageRequestHandler.perform(self.requests2)
        } catch {
            print(error)
        }
    }
    
    private func detectFace(in image: CVPixelBuffer) {
        
        let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
            
            DispatchQueue.main.async {
                if let results = request.results as? [VNFaceObservation], results.count > 0 {
                    AppManager.shared.didShowFace = true
                } else {
                    AppManager.shared.didShowFace = false
                }
            }
        })
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([faceDetectionRequest])
    }
    
    /*
    private func handleFaceDetectionResults(_ observedFaces: [VNFaceObservation]) {
        
        self.clearDrawings()
        let facesBoundingBoxes: [CAShapeLayer] = observedFaces.flatMap({ (observedFace: VNFaceObservation) -> [CAShapeLayer] in
            let faceBoundingBoxOnScreen = self.previewLayer.layerRectConverted(fromMetadataOutputRect: observedFace.boundingBox)
            let faceBoundingBoxPath = CGPath(rect: faceBoundingBoxOnScreen, transform: nil)
            let faceBoundingBoxShape = CAShapeLayer()
            faceBoundingBoxShape.path = faceBoundingBoxPath
            faceBoundingBoxShape.fillColor = UIColor.clear.cgColor
            faceBoundingBoxShape.strokeColor = UIColor.green.cgColor
            var newDrawings = [CAShapeLayer]()
            newDrawings.append(faceBoundingBoxShape)
            if let landmarks = observedFace.landmarks {
                newDrawings = newDrawings + self.drawFaceFeatures(landmarks, screenBoundingBox: faceBoundingBoxOnScreen)
            }
            return newDrawings
        })
        facesBoundingBoxes.forEach({ faceBoundingBox in self.view.layer.addSublayer(faceBoundingBox) })
        self.drawings = facesBoundingBoxes
    }

    
    private func clearDrawings() {
        self.drawings.forEach({ drawing in drawing.removeFromSuperlayer() })
    }

    private func drawFaceFeatures(_ landmarks: VNFaceLandmarks2D, screenBoundingBox: CGRect) -> [CAShapeLayer] {
        var faceFeaturesDrawings: [CAShapeLayer] = []
        if let leftEye = landmarks.leftEye {
            let eyeDrawing = self.drawEye(leftEye, screenBoundingBox: screenBoundingBox)
            faceFeaturesDrawings.append(eyeDrawing)
        }
        if let rightEye = landmarks.rightEye {
            let eyeDrawing = self.drawEye(rightEye, screenBoundingBox: screenBoundingBox)
            faceFeaturesDrawings.append(eyeDrawing)
        }
        // draw other face features here
        return faceFeaturesDrawings
    }
    
    private func drawEye(_ eye: VNFaceLandmarkRegion2D, screenBoundingBox: CGRect) -> CAShapeLayer {
        let eyePath = CGMutablePath()
        let eyePathPoints = eye.normalizedPoints
            .map({ eyePoint in
                CGPoint(
                    x: eyePoint.y * screenBoundingBox.height + screenBoundingBox.origin.x,
                    y: eyePoint.x * screenBoundingBox.width + screenBoundingBox.origin.y)
             })
        eyePath.addLines(between: eyePathPoints)
        eyePath.closeSubpath()
        let eyeDrawing = CAShapeLayer()
        eyeDrawing.path = eyePath
        eyeDrawing.fillColor = UIColor.clear.cgColor
        eyeDrawing.strokeColor = UIColor.green.cgColor
        
        return eyeDrawing
    }
     */
    
    let faceShapeLabels: [String] = ["Heart", "Oblong", "Oval", "Round", "Square"]
    let skinToneLabels: [String] = ["Olive", "White", "Dark"] // olive: 0, white: 1, dark: 2
    
    
}


