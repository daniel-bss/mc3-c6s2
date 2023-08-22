//
//  GlassesCard.swift
//  FrameGlasses
//
//  Created by Anisya Dewi Larasati on 21/08/23.
//

import SwiftUI

struct GlassesCard: View {
    
    var glasses: Glasses
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(glasses.image)
                .resizable()
                .frame(width: 147, height: 73)
                .padding()
            
            VStack(alignment: .leading) {
                HStack(spacing: 6){
                    ForEach(glasses.colorAvailable, id: \.self) {
                        c in
                        Circle()
                            .fill(Color(c))
                            .frame(width: 17, height: 17)
                            .background(Circle()    .stroke(Color.black, lineWidth: 1))
                    }
                }
                
                Text(glasses.name)
                    .font(.footnote)
                
                Spacer().frame(height: 4)
                
                Text(glasses.price)
                    .font(.body)
                    .fontWeight(.semibold)
                
                Spacer().frame(height: 4)
                
                Text(glasses.optic)
                    .font(.caption2)
            }
            .frame(width: 140)
           
        }
        .frame(width: 170, height: 208, alignment: .top)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    
    }
}

struct GlassesCard_Previews: PreviewProvider {
    static var previews: some View {
        GlassesCard(glasses: Glasses.all[0])
    }
}
