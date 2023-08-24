//
//  ARCircleView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 23/08/23.
//

import SwiftUI

struct ARCircleView: View {
//    @Binding let imageName: String
//    let imageName: String
    let index: Int
    let width: Double = 56 * 1.5 // = 84
    let padding: Double = 10
    var widthPadding: Double {
        width + padding
    }
    @State var isMain: Bool = false
    
    @Binding var xOffset: Double
    
    @State var latestOffest: Double = 0
    
    var body: some View {
//        ZStack {
//            Color.black.opacity(0.3)
            Circle()
                .fill(.white)
                .overlay(GeometryReader {
                    let side = sqrt($0.size.width * $0.size.width)
                    VStack {
                        Rectangle().foregroundColor(.clear)
                            .frame(width: side, height: side)
                            .overlay(
                                Image(AppManager.shared.frameName[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                })
                .frame(width: width, height: width)
//                .offset(CGSize(width: self.xOffset + (Double(index) * (width + padding)) - 100, height: 0))
                .offset(CGSize(width: self.xOffset, height: 0))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
//                            self.xOffset = self.latestOffest + value.translation.width
                            print(value.translation)
                        })
                        .onEnded({ value in
//                            withAnimation(.easeOut(duration: 0.2)) {
//                                self.latestOffest = ((floor((value.translation.width + 30) / widthPadding)) * widthPadding)
//                                print(ceil(value.translation.width / widthPadding))
//                                self.xOffset = self.latestOffest
//                            }
                            print(value.translation)
                            self.xOffset = 0
                            
                        })
                )
//        }
    }
}

//struct ARCircleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARCircleView(index: 0)
//    }
//}
