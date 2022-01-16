//
//  BusinessSectionHeader.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/4/22.
//

import SwiftUI

struct BusinessSectionHeader: View {
    
    var title:String
    var body: some View {
       
        ZStack(alignment:.leading){
        
        Rectangle()
            .foregroundColor(.white)
        
        Text(title).font(.headline)
        }
    }
}



