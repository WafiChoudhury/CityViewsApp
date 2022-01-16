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
    @State var selectedBusiness:Buisness?
    
    var body: some View {
        
        if(model.restaraunts.count > 0 || model.arts.count != 0){
            
            NavigationView{
                
                if(!isMapShowing){
                    
                    //show list
                    
                    VStack(alignment: .leading){
                        
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text("San Francisco")
                            Spacer()
                            Button("Toggle map view"){
                                self.isMapShowing = true
                            }
                        }
                        Divider()
                        BusinessList()
                    }.padding([.horizontal,.top])
                    .navigationBarHidden(true)
                }
                else{
                    
                    ZStack (alignment: .top){
                    
                    BusinessMap(selectedBusiness: $selectedBusiness)
                        .ignoresSafeArea()
                        .sheet(item: $selectedBusiness) { business in
                            
                            BusinessDetail(business: business)
                            
                        }
                    
                    ZStack{
                        
                        Rectangle().foregroundColor(.white)
                            .cornerRadius(5)
                            .frame(height: 48)
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text("San Francisco")
                            Spacer()
                            Button("Toggle list view"){
                                self.isMapShowing = false
                            }
                        
                        }.padding()
                    }.padding()
                
            }
  
                }
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
