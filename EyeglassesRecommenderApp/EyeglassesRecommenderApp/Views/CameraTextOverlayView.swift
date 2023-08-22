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
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect().eraseToAnyPublisher()
    
    @State var didShowFace: Bool = false
    @State var finishedScanning: Bool = false
    @State var isProcessing: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black.opacity(0.7))
                .mask(Window())
            
            Arc(startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
                .stroke(.white, lineWidth: 10)
                .frame(width: 177 * 2, height: 177 * 2)
            
            // HIJAU
            if didShowFace {
                Arc(startAngle: .degrees(270), endAngle: .degrees(x), clockwise: false)
                    .stroke(.green, lineWidth: 12)
                    .frame(width: 177 * 2, height: 177 * 2)
                
                    .onAppear {
                        self.x = 270.01
                        for i in 1...5 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                                withAnimation {
                                    x += multiplier
                                }
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            self.finishedScanning = true
                            AppManager.shared.isLoading = true
                        }

                    }
            }
            
            Text(getInstructions())
                .offset(y: 220)
                .font(.system(size: 22))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .onReceive(timer) { _ in
                    self.didShowFace = AppManager.shared.didShowFace
                    
                    if !self.didShowFace {
                        AppManager.shared.isLoading = false
                        self.finishedScanning = false
                    }
                }
        }
        .ignoresSafeArea()
    }
    
    func getInstructions() -> String {
        if didShowFace && !finishedScanning {
            return Instructions.moveYourHead.rawValue
        } else if !didShowFace && !finishedScanning {
            return Instructions.positionYourFace.rawValue
        } else if finishedScanning && AppManager.shared.isLoading {
            return Instructions.faceScanIsComplt.rawValue
        } else if finishedScanning && !AppManager.shared.isLoading {
            return Instructions.processing.rawValue
        }
        else {
            return "MANTAPPP"
        }
    }
}

//struct CameraTextOverlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraTextOverlayView()
//    }
//}
