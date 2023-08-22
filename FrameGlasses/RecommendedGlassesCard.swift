//
//  RecommendedGlassesCard.swift
//  FrameGlasses
//
//  Created by Anisya Dewi Larasati on 22/08/23.
//

import SwiftUI

struct RecommendedGlassesCard: View {
    
    var glasses: Glasses
    
    var body: some View {
        ZStack{
          
            HStack{
                Image(glasses.image)
                    .resizable()
                    .frame(width: 80, height: 40)
                    .padding(.horizontal, 4.0)
                    .padding(.leading, 7.0)
                    
                
                VStack(alignment: .leading, spacing: 4){
                    Text(glasses.name)
                        .font(.subheadline)
                    
                    Text(glasses.price)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Text(glasses.optic)
                        .font(.caption2)
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Button {} label: {
                        Text("Check Details")
                            .font(.subheadline)
                            .padding(.vertical, 4.0)
                            .padding(.trailing, 10)
                            .padding(.leading, 10)
                            .foregroundColor(Color("Blue-Primary"))
                            .background(Color("Blue-00").cornerRadius(40))
                    }.padding(.vertical)
                        .padding(.trailing, 8)
                    
                  
                }
            }
            
        }
        .frame(width: 361, height: 95)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct RecommendedGlassesCard_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedGlassesCard(glasses: Glasses.all[0])
    }
}
