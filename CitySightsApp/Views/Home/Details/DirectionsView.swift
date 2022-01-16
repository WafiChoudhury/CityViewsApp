//
//  DirectionsView.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/12/22.
//

import SwiftUI

struct DirectionsView: View {
    
    var business: Buisness
    
    
    var body: some View {

        VStack(alignment:.leading){
            
            HStack{
            BusinessTitle(business: business)
            Spacer()
                
                if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude,
                   let name = business.name{
                    Link(destination: URL(string: "http://maps.apple.com/?\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!, label: {
                    Text("Open in maps")
                })
                
                }
            }.padding()
            
            DirectionsMap(business: business)
                .ignoresSafeArea(.all, edges: .bottom)
            
        }


    }
}

