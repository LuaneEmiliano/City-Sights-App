//
//  City_Sights_AppApp.swift
//  City Sights App
//
//  Created by luane Niejelski on 6/26/22.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
