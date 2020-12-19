//
//  CustomPlace.swift
//  I Know A Spot
//
//  Created by Nathan Davenport on 12/18/20.
//

import Foundation
import GooglePlaces

struct CustomPlace: Hashable, CustomStringConvertible {
    var id: Int
    var placeLikelihood: GMSPlaceLikelihood
    
    var description: String {
        return "\ncustom id: \(id), place data: (\(placeLikelihood))"
    }
}
