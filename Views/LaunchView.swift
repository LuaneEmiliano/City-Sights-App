//
//  ContentView.swift
//  City Sights App
//
//  Created by luane Niejelski on 6/26/22.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect the authorization status of geolocating the user
        
        if model.authorizationState == .notDetermined {
        // If undertermined, show onboarding
        }
        else if model.authorizationState == CLAuthorizationStatus.authorizedAlways || model.authorizationState == CLAuthorizationStatus.authorizedWhenInUse {
        // If approved show home view
            HomeView()
        }
        else {
        //If denied show denied view
            
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
     LaunchView()
    }
}
