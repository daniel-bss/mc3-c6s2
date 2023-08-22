//
//  GlassesModel.swift
//  FrameGlasses
//
//  Created by Anisya Dewi Larasati on 21/08/23.
//

import Foundation

struct Glasses: Identifiable{
    let id = UUID()
    let name: String
    let image: String
    let price: String
    let optic: String
    let material: String
    let frameWidth: String
    let lensWidth: String
    let lensHeight: String
    let bridgeWidth: String
    let templeLength: String
    let colorAvailable: [String]
}

extension Glasses {
    static let all: [Glasses] = [
        Glasses(name: "Equality Glasses", image: "equality-pink", price: "Rp 500.000", optic: "eyebuydirect", material: "Acetate-Metal", frameWidth: "130 mm", lensWidth: "55 mm", lensHeight: "43 mm", bridgeWidth: "15 mm", templeLength: "55mm", colorAvailable: ["Pink", "Green", "Blue"]),
        Glasses(name: "Equality Glasses", image: "equality-blue", price: "Rp 500.000", optic: "eyebuydirect", material: "Acetate-Metal", frameWidth: "130 mm", lensWidth: "55 mm", lensHeight: "43 mm", bridgeWidth: "15 mm", templeLength: "55mm", colorAvailable: ["Pink", "Green", "Blue"]),
        Glasses(name: "Equality Glasses", image: "equality-green", price: "Rp 500.000", optic: "eyebuydirect", material: "Acetate-Metal", frameWidth: "130 mm", lensWidth: "55 mm", lensHeight: "43 mm", bridgeWidth: "15 mm", templeLength: "55mm", colorAvailable: ["Pink", "Green", "Blue"])
    ]
}
