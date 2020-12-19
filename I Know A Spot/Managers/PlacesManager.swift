//
//  PlacesManager.swift
//  I Know A Spot
//
//  Created by Nathan Davenport on 12/15/20.
//

import Foundation
import GooglePlaces

class PlacesManager: NSObject, ObservableObject {
    // 1
    private var placesClient = GMSPlacesClient.shared()
    // 2
    @Published var places = [GMSPlaceLikelihood]()
    @Published var customPlaces = [CustomPlace]()
    @Published var currentPlace = self
    
    override init() {
        super.init()
        currentPlacesList { (places) in
            guard let places = places else { return }
            self.places = places
        }
    }
     
    func currentPlacesList(completion: @escaping (([GMSPlaceLikelihood]?) -> Void)) {
        // 3
        placesClient.currentPlace { (placeLikelyHoodList, error) in
            if let error = error {
                print("Places failed to initialize with error \(error)")
                completion(nil)
                return
            }
            
            guard let placeLikelyHoodList = placeLikelyHoodList else { return }
            self.places = placeLikelyHoodList.likelihoods
            for placeLikelihood in placeLikelyHoodList.likelihoods {
                self.customPlaces.append(CustomPlace(id: self.customPlaces.count, placeLikelihood: placeLikelihood))
            }
            
            // for debugging
            print(self.customPlaces)
            
            completion(self.places)
        }
    }
}
