//  Just the backup for my testing stuff
//  ContentView.swift
//  I Know A Spot
//
//  Created by Nathan Davenport on 12/15/20.
//

import Foundation
import SwiftUI
import GoogleMaps
import GooglePlaces



struct TestView: View {
    
    @ObservedObject private var placesManager = PlacesManager()
    


    // 1
    /// List of landmarks
    @State var landmarks: [Landmark] = [
        Landmark(id: 0, place: nil, firstName: "kill me", lastName: "Jones", age: 23, mutualFriends: 4, imageName: "person_1", occupation: "Coach"),
        Landmark(id: 1, place: nil, firstName: "Mark", lastName: "Bennett", age: 27, mutualFriends: 0, imageName: "person_2", occupation: "Insurance Agent"),
        Landmark(id: 2, place: nil, firstName: "Clayton", lastName: "Delaney", age: 20, mutualFriends: 1, imageName: "person_3", occupation: "Food Scientist"),
        Landmark(id: 3, place: nil, firstName: "Brittni", lastName: "Watson", age: 19, mutualFriends: 4, imageName: "person_4", occupation: "Historian"),
        Landmark(id: 4, place: nil, firstName: "Archie", lastName: "Prater", age: 22, mutualFriends:18, imageName: "person_5", occupation: "Substance Abuse Counselor"),
        Landmark(id: 5, place: nil, firstName: "James", lastName: "Braun", age: 24, mutualFriends: 3, imageName: "person_6", occupation: "Marketing Manager"),
        Landmark(id: 6, place: nil, firstName: "Danny", lastName: "Savage", age: 25, mutualFriends: 16, imageName: "person_7", occupation: "Dentist"),
        Landmark(id: 7, place: nil, firstName: "Chi", lastName: "Pollack", age: 29, mutualFriends: 9, imageName: "person_8", occupation: "Recreational Therapist"),
        Landmark(id: 8, place: nil, firstName: "Josue", lastName: "Strange", age: 23, mutualFriends: 5, imageName: "person_9", occupation: "HR Specialist"),
        Landmark(id: 9, place: nil, firstName: "Debra", lastName: "Weber", age: 28, mutualFriends: 13, imageName: "person_10", occupation: "Judge")
    ]
    
    func viewDidLoad() {
        //landmarks[0].place = placesManager.places[0].place
        //landmarks[1].place = placesManager.places[1].place
        //landmarks[2].place = placesManager.places[2].place
        //landmarks[3].place = placesManager.places[3].place
        //landmarks[4].place = placesManager.places[4].place
        //landmarks[5].place = placesManager.places[5].place
        //landmarks[6].place = placesManager.places[6].place

    }
    

    
    // 2
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current landmark
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(landmarks.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    // 3
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current landmark
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(landmarks.count - 1 - id) * 10
    }
    
    // Compute what the max ID in the given users array is.
    private var maxID: Int {
        return self.landmarks.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        
        TabView {
            // tab 1
            VStack {
                // 4
                GeometryReader { geometry in
                    // 5
                    VStack {
                        DateView()
                        // 6
                        ZStack {
                            // 7
                            ForEach(self.landmarks, id: \.self) { landmark in
                                
                                /// Using the pattern-match operator ~=, we can determine if our
                                /// user.id falls within the range of 6...9
                                if (self.maxID - 3)...self.maxID ~= landmark.id {
                                    // Normal Card View being rendered here.
                                    CardView(landmark: landmark, onRemove: { removedLandmark in
                                       // Remove that landmark from our array
                                        
                                       self.landmarks.removeAll { $0.id == removedLandmark.id }
                                      })
                                      .animation(.spring()) // Animate our changes to our frame
                                      .frame(width: self.getCardWidth(geometry, id: landmark.id),
                                             height: 520)
                                      .offset(x: 0, y: self.getCardOffset(geometry, id: landmark.id))
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }.padding()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Explore")
                }
            
            // tab 2
            PlacesList()
                .tabItem {
                    Image(systemName: "star")
                    Text("My Places")
                }
            
            // tab 3 testing new place cards
            VStack {
                // 4
                GeometryReader { geometry in
                    // 5
                    VStack {
                        DateView()
                        // 6
                        ZStack {
                            // 7

                            //ForEach(placesManager.places, id: \.place.placeID) { placeLikelihood in
                            ForEach(placesManager.customPlaces, id: \.id) { customPlace in

                                /// Using the pattern-match operator ~=, we can determine if our
                                /// user.id falls within the range of 6...9
                                if (self.maxID - 3)...self.maxID ~= customPlace.id {
                                    // Normal Card View being rendered here.
                                PlaceCardView(customPlace: customPlace, onRemove: { removedPlace in
                                       // Remove that landmark from our array
                                        
                                    self.placesManager.customPlaces.removeAll { $0.id == removedPlace.id} //
                                      })
                                      .animation(.spring()) // Animate our changes to our frame
                                      .frame(width: self.getCardWidth(geometry, id: customPlace.id),
                                             height: 520)
                                      .offset(x: 0, y: self.getCardOffset(geometry, id: customPlace.id))
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }.padding()
                .tabItem {
                    Image(systemName: "questionmark")
                    Text("Test")
                }
        }
        .font(.headline)


    }
}


// 2


struct TestView_Previews: PreviewProvider {
    static var previews: some View {

        TestView()
    }
}
