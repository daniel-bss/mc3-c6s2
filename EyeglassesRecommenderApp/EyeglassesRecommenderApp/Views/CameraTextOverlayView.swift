//
//  CameraTextOverlayView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import SwiftUI

struct Window: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Rectangle().path(in: rect)

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 177, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        return path
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)

        return path
    }
}

struct CameraTextOverlayView: View {
    @State var x: Double = 270.01 // 270 ke 270
    var multiplier: Double = 360.0 / 5
    @StateObject var vm = FaceDetectionEnvironmentObject()
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black.opacity(0.7))
                .mask(Window())
            
            Arc(startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
                .stroke(.white, lineWidth: 10)
                .frame(width: 177 * 2, height: 177 * 2)
            
            Arc(startAngle: .degrees(270), endAngle: .degrees(x), clockwise: false)
                .stroke(.green, lineWidth: 12)
                .frame(width: 177 * 2, height: 177 * 2)
            
            
            Text(vm.didShowFace ? AppManager.moveYourHead : AppManager.positionYourFace)
                .offset(y: 220)
                .font(.system(size: 22))
                .fontWeight(.semibold)
                .foregroundColor(.white)
//                .onre(of: AppManager.shared.didShowFace, perform: { newValue in
                .onAppear {
                    if !AppManager.shared.didShowFace {
                        for i in 1...5 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                                withAnimation {
                                    x += multiplier
                                }
                            }
                        }
                    }
                }
        }
        .ignoresSafeArea()
    }
}

struct CameraTextOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        CameraTextOverlayView()
    }
}
