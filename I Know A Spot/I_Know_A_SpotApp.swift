//
//  I_Know_A_SpotApp.swift
//  I Know A Spot
//
//  Created by Nathan Davenport on 12/15/20.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

@main
struct I_Know_A_SpotApp: App {
    
    init() {
        setupGoogleMaps();
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private extension I_Know_A_SpotApp {
    func setupGoogleMaps() {
        // Google maps credentials
        // gmaps api key: AIzaSyAOCusCCqhrFrtbWPnElNY_D6g6p0Zugdo

        GMSServices.provideAPIKey("AIzaSyAOCusCCqhrFrtbWPnElNY_D6g6p0Zugdo");
        GMSPlacesClient.provideAPIKey("AIzaSyAOCusCCqhrFrtbWPnElNY_D6g6p0Zugdo");
    }
}
