//
//  FindOutWhyView.swift
//  EyeglassesRecommenderApp
//
//  Created by Daniel Bernard Sahala Simamora on 24/08/23.
//

import SwiftUI

struct FindOutWhyView: View {
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 500)
                    .foregroundColor(.blueLight)
                    .frame(width: 125, height: 36)
                HStack {
                    Image(systemName: "info.circle")
                    Text("Find out why")
                        .font(.system(size: 13))
                }
            }
            .foregroundColor(.bluePrimary)
        }
        .frame(width: 115, height: 36)
        
    }
}

struct FindOutWhyView_Previews: PreviewProvider {
    static var previews: some View {
        FindOutWhyView()
    }
}
