//
//  PlaceRow.swift
//  I Know A Spot
//
//  Created by Nathan Davenport on 12/15/20.
//

import Foundation
import SwiftUI
import GooglePlaces

struct PlaceRow: View {
    // 1
    var place: GMSPlace
    
    var body: some View {
        NavigationLink(destination:
            VStack(){
                Text(place.name!)
                Text(place.formattedAddress!)
            }
        ) {
            HStack {
                // 2
                Text(place.name ?? "")
                    //.foregroundColor(.white)
                Spacer()
            }
        }
    }
}
