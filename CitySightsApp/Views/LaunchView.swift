//
//  LaunchView.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/3/22.
//

import SwiftUI
import CoreLocation


struct LaunchView: View {
    
    @EnvironmentObject var model:ContentModel
    
    
    var body: some View {
        
        
        if(model.authorizationState == .notDetermined){
            //show onboarding

            OnboardingView()
        }
        else if (model.authorizationState == CLAuthorizationStatus.authorizedAlways || model.authorizationState == CLAuthorizationStatus.authorizedWhenInUse){
            
            HomeView()
        }
        else{
            //show denied
            OnboardingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
