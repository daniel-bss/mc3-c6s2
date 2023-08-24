//
//  OnboardingView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 22/08/23.
//

import SwiftUI

struct OnboardingView: View {
    
    var body: some View {
        NavigationStack {
            Image(systemName: "faceid")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 78)
                .foregroundColor(.bluePrimary)
                .padding(.bottom, 12)
                .padding(.top, -80)

            
            Text("Face Scanning Preparation")
                .font(.system(size: 28))
                .fontWeight(.bold)
                .padding(.bottom, 32)


            
            HStack {
                Image(systemName: "eyeglasses")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 56)
                    .fontWeight(.bold)

                Text("Remove eyeglasses — we want a clear view of your beautiful face.")
                    .font(.system(size: 16))
                    .frame(width: 265)
                    .offset(x: -6)

            }
            HStack {
                Image(systemName: "facemask")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48)
                    .fontWeight(.bold)
                Text("Take off any face masks — full visibility ensures optimal scanning.")
                    .font(.system(size: 16))
                    .frame(width: 265)
                    .offset(x: 3)

            }
            HStack {
                Image(systemName: "face.smiling")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .fontWeight(.bold)
                Text("Clear away any other facial accessories.")
                    .font(.system(size: 16))
                    .frame(width: 265)
                    .offset(x: -15)
            }
            
            NavigationLink {
                RootFaceDetectionView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.bluePrimary)
                        .frame(width: 361, height: 50)
                    Text("Start scanning")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                }
            }
            .offset(y:185)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
