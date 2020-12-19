//
//  ContentView.swift
//  I Know A Spot
//
//  Created by Nathan Davenport on 12/18/20.
//


import Foundation
import SwiftUI
import GoogleMaps
import GooglePlaces



struct ContentView: View {
    
    @ObservedObject private var placesManager = PlacesManager()
    

    // 2
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current landmark
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(placesManager.customPlaces.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    // 3
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current landmark
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(placesManager.customPlaces.count - 1 - id) * 10
    }
    
    // Compute what the max ID in the given users array is.
    private var maxID: Int {
        return self.placesManager.customPlaces.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        
        TabView {
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
                    Image(systemName: "globe")
                    Text("Explore")
                }
            
            
            // tab 2
            PlacesList()
                .tabItem {
                    Image(systemName: "star")
                    Text("My Places")
                }
            
        }
        .font(.headline)


    }
}


// 2
struct DateView: View {
    var body: some View {
      // Container to add background and corner radius to
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Explore")
                        .font(.largeTitle)
                        .bold()
                }
                Spacer()
            }
        }
        .padding(.top, 30)
        .padding(.bottom, 20)
        //.padding(.leading, 10)
        //.background(Color.white)
        //.cornerRadius(10)
        //.shadow(radius: 5)
    }
}

struct ConentView_Previews: PreviewProvider {
    static var previews: some View {

        ContentView()
    }
}
