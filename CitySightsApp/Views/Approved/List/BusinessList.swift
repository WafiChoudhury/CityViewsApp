//
//  BusinessList.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/4/22.
//

import SwiftUI

struct BusinessList: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        
        ScrollView (showsIndicators: false){
            
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]){
                
                Section(header: BusinessSectionHeader(title: "Food"))
                {
                    
                    ForEach(model.restaraunts) { Buisness in
                        BusinessRow(business: Buisness)

                    
                    }
                }
               
                Section(header:BusinessSectionHeader(title: "Sights"))
                {
                    ForEach(model.arts) { Buisness in
                       BusinessRow(business: Buisness)
                    
                    }
                }
        }
    
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
        }
    }
}
