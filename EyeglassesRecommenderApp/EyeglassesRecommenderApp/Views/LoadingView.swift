//
//  LoadingView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 23/08/23.
//

import SwiftUI

struct LoadingView: View{
    
    @State var currentIndex: Int = 0
    @State var currentOffset = CGSize.zero
    
    let numberOfLeaves = 8
    
    var body: some View{
        ZStack{
            Color.black.opacity(0.7)
            ForEach(0 ..< numberOfLeaves){ index in
                Leaf(
                    rotation: Angle.degrees( Double(index) / Double(numberOfLeaves) * 360.0 ),
                    isCurrent: index == currentIndex)
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
                if currentIndex < numberOfLeaves{
                    currentIndex += 1
                }else{
                    currentIndex = 0
                }
            }
        })

    }
}

struct Leaf: View{
    
    let rotation: Angle
    let isCurrent: Bool
    
    var body: some View{
        ZStack{
            Capsule()
                .trim(
                    from: isCurrent ?   0.2 : 0,
                    to: isCurrent ?    0 : 1)
                .stroke(isCurrent ? Color.gray : Color.white, lineWidth: 5)
                .offset(x: isCurrent ? 5 : 0, y: isCurrent ? 10 : 70)
                .scaleEffect(
                    CGSize(
                        width: isCurrent ? 1 : 0.7,
                        height: isCurrent ? 1 : 0.7),
                    anchor: .center)
                .opacity( isCurrent ? 0 : 1)
                .foregroundColor(.white)
                .frame(width: 20, height: 50, alignment: .center)
                .rotationEffect(rotation, anchor: .center)
                .animation(
                    .easeIn
                        .speed(1)
                    ,
                    value: isCurrent)
            
            Capsule()
                .trim(
                    from: isCurrent ? 0 : 0.2,
                    to: isCurrent ? 1: 0)
                .stroke(isCurrent ? Color.gray : Color.white, lineWidth: 5)
                .offset(x: isCurrent ? 5 : 0, y: isCurrent ? 10 : 70)
                .scaleEffect(
                    CGSize(
                        width: isCurrent ? 1 : 0.7,
                        height: isCurrent ? 1 : 0.7),
                    anchor: .center)
                .opacity( isCurrent ? 0 : 1)
                .foregroundColor(.white)
                .frame(width: 20, height: 50, alignment: .center)
                .rotationEffect(rotation, anchor: .center)
                .animation(
                    .easeIn
                        .speed(1)
                    ,
                    value: isCurrent)
        }
    }
}

//struct LeafSpinner_Previews: PreviewProvider {
//    static var previews: some View {
//        LeafSpinner()
//    }
//}

