//
//  HomeView.swift
//  City Sights App
//
//  Created by luane Niejelski on 6/26/22.
//

import SwiftUI

struct HomeView: View {
  
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
   var body: some View {
       
       if model.restaurants.count != 0 || model.sights.count != 0 {
         // Determine if we should show list or map
           if !isMapShowing {
//           Show list
               VStack (alignment: .leading) {
                   HStack {
                       Image(systemName: "location")
                       Text("San Francisco")
                       Spacer()
                       Text("Switch to map view")
                   }
                   Divider()
               }
               BusinessList()
           }
       else {
//           Still waiting for data to show spinner
       }
    }
        else {
        ProgressView()
    }
  }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
