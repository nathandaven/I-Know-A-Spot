//
//  Landmark.swift
//  I Know A Spot
//
//  Created by Nathan Davenport on 12/16/20.
//

import Foundation
import GoogleMaps
import GooglePlaces


struct Landmark: Hashable, CustomStringConvertible {
    var id: Int
    
    //var place: GMSPlace?
    var place: GMSPlace?

    let firstName: String
    let lastName: String
    let age: Int
    let mutualFriends: Int
    let imageName: String
    let occupation: String
    
    
    
    var description: String {
        return "\(firstName), id: \(id)"
    }
    

}
