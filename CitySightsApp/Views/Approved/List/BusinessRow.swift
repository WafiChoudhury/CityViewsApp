//
//  BusinessRow.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/5/22.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business:Buisness
    
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            HStack{
                
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
     
                //for name and distance
                VStack(alignment: .leading){
                    
                    Text(business.name ?? "")
                    
                    
                    Text(String(format:"%.1f miles away", (business.distance ?? 0 *  0.000621371) ))
                        .font(.caption)
                    
                    
                }
                Spacer()
                
                //for star and reviews
                VStack(alignment: .leading){
                    
                    Image("regular_\(business.rating ?? 0)")
                    Text(String(business.reviewCount ?? 0) + " Reviews")
                        .font(.caption)
                    
                }
            }
            Divider()
        }
        
        
        
    }
}

