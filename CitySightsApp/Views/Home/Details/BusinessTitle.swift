//
//  BusinessTitle.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/12/22.
//

import SwiftUI

struct BusinessTitle: View {
    var business:Buisness
    
    var body: some View {
        
        VStack (alignment:.leading){
        
            Text(business.name!)
                .font(.largeTitle)
            
            //Adress
            
            if(business.location?.display_address != nil){
            ForEach(business.location!.display_address!, id:\.self) { displayLine in
                Text(displayLine)
            }
            }
            //rating
            Image("regular_\(business.rating ?? 0)")

        //phone    }
        }
    }
}
