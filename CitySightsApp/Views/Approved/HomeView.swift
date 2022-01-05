//
//  HomeView.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/4/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model:ContentModel
    
    @State var isMapShowing = false
    
    var body: some View {
        
        if(model.restaraunts.count != 0 || model.arts.count != 0){
            
            if (isMapShowing){
                
                //show map
            }
            if(!isMapShowing){
                
                //show list
                
                VStack(alignment: .leading){
                    
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                        Text("San Francisco")
                        Spacer()
                        Text("Switch to ")
                    }
                    Divider()
                    BusinessList()
                }.padding([.horizontal,.top])
            }
            
            
        }
        else{
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
