//
//  AppManager.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import Foundation

class AppManager {
    static let shared = AppManager()
    private init() {}
    
    var didShowFace: Bool = false
    var isLoading: Bool = false
    
    var frameColors: [String] = ["red", "green", "blue", "black", "pink", "gold"]
    
    var frameName: [String] = [
        "revel-black",
        "ezra-gold",
        "elm-green",
        "atlas-green",
        "intense-blue", "intense-pink",
        "equality-red", "equality-green", "equality-blue",
        "aperture-blue", "aperture-red",
    ]
    
    var faceLabelContainer: [Int] = []
    var skinToneLabelContainer: [Int] = []
    
    let faceShapeLabels: [String] = ["heart", "oblong", "oval", "round", "square"]
    let skinToneLabels: [String] = ["olive", "white", "dark"] // olive: 0, white: 1, dark: 2
    
    let frames: [Frame] = [
        Frame(shapeModel: "rectangle", color: "pink"),
        Frame(shapeModel: "rectangle", color: "green"),
        Frame(shapeModel: "rectangle", color: "blue"),
        Frame(shapeModel: "square", color: "blue"),
        Frame(shapeModel: "square", color: "pink"),
        Frame(shapeModel: "round", color: "green"),
        Frame(shapeModel: "round", color: "pink"),
        Frame(shapeModel: "oval", color: "pink"),
        Frame(shapeModel: "oval", color: "blue"),
        Frame(shapeModel: "cateye", color: "green"),
        Frame(shapeModel: "aviator", color: "gray")
    ]
    
    let faceToFrame: [String: [String]] = [
        "heart": ["round", "oval", "aviator"],
        "oblong": ["round", "oval", "cateye"],
        "oval": ["rectangle", "square", "round", "cateye", "aviator"],
        "round": ["rectangle", "square"],
        "square": ["round", "oval"]
    ]
    
    let skinToneToColor: [String: [String]] = [
        "light": ["pink", "gray"],
        "medium": ["green", "blue", "pink"  ],
        "dark": ["blue", "green"]
    ]
    
    let availableUsdzAssets: [String] = [
        "square-medium-pink",
        "square-medium-blue",
        "aviator-light-gray",
        "rectangle-dark-blue",
        "rectangle-medium-green",
        "rectangle-light-pink",
        "oval-light-pink",
        "oval-medium-blue",
        "cateye-dark-green",
        "round-medium-green",
        "round-light-pink"
    ]
    
//    let satu = "Dark-Bluexy"
//    let dua = "Light-Pinkxy"
//    
//    let bentukWajah: String = "heart"
//    let warnaKulit: String = "light"
    
    /*
     Oval -> Rectangle, Square, Round, Cat Eye, Aviator,
     Round -> Rectangle, Square, Geometric
     Square -> Round, Oval. Wire, Semi rimless
     (OBLONG?) Diamond-Shaped Face -> Cat eye, Round, Oval
     -Heart -> Oval, Aviator, Round
     */
    
    /*
     {'Heart': 0, 'Oblong': 1, 'Oval': 2, 'Round': 3, 'Square': 4}
     */
    
    
    func getModeValue(_ array: [Int]) -> Int {
        var container: [Int] = []
        var containerDict: [Int: Int] = [:]

        for value in array {
            if !container.contains(value) {
                container.append(value)
            }
        }
        
        for value in container {
            containerDict[value] = 0
        }
        
        for value in array {
            containerDict[value] = containerDict[value]! + 1
        }

        var z = containerDict.keys.first!
        for key in containerDict.keys {
            if containerDict[z]! < containerDict[key]! {
                z = key
            }
        }
        
        return z
    }
    
    func getFrameRecommendations(faceShape: String, skinTone: String) -> [String] {
        var frameContainersTemp: [String] = []
        var frameContainersTemp2: [String] = []
        var frameContainers: [String] = []
        
        guard let frames: [String] = faceToFrame[faceShape] else { return [""] }
        guard let colors: [String] = skinToneToColor[skinTone] else { return [""] }
        
        for frame in frames {
            frameContainersTemp.append("\(frame)-\(skinTone)")
        }
        
        for color in colors {
            for frame in frameContainersTemp {
                frameContainersTemp2.append("\(frame)-\(color)")
            }
        }
        
        for frame in availableUsdzAssets {
            let filtered = frameContainersTemp2.filter({ value in
                return value == frame
            })
            frameContainers.append(contentsOf: filtered)
        }
        
        return frameContainers
    }
    
    func getFrameRecommendations2(faceShape: String, skinTone: String) -> [String] {
        var frameContainersTemp: [String] = []
        var frameContainers: [String] = []
        
        guard let frames: [String] = faceToFrame[faceShape] else { return [""] }
        guard let colors: [String] = skinToneToColor[skinTone] else { return [""] }
        
        for frame in frames {
            frameContainersTemp.append("\(frame)-\(skinTone)")
        }
        
        for color in colors {
            for frame in frameContainersTemp {
                frameContainers.append("\(frame)-\(color)")
            }
        }
        
        return frameContainers
    }

}

enum Instructions: String {
    case positionYourFace = "Position your face within the frame"
    case moveYourHead = "Hold still until the circle fills up."
    case repositionYourFace = "Reposition your face within the frame"
    case faceScanIsComplt = "Face scanning is now complete"
    case processing = "Face scanning is now complete."
}
