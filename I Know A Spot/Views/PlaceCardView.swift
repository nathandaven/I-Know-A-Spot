//
//  PlaceCardView.swift
//  I Know A Spot
//
//  Created by Nathan Davenport on 12/18/20.
//

import Foundation
import SwiftUI
import GoogleMaps
import GooglePlaces

struct PlaceCardView: View {
    @State private var translation: CGSize = .zero
    
    // for detail view
    @State var showingDetail = false

    
    // 1
    private var customPlace: CustomPlace
    private var onRemove: (_ place: CustomPlace) -> Void
    
     // 2
    private var thresholdPercentage: CGFloat = 0.5 // when the user has draged 50% the width of the screen in either direction
    

    
    // 3
    init(customPlace: CustomPlace, onRemove: @escaping (_ customPlace: CustomPlace) -> Void) {
        self.customPlace = customPlace
        self.onRemove = onRemove
    }
    
     // 4
    /// What percentage of our own width have we swipped
    /// - Parameters:
    ///   - geometry: The geometry
    ///   - gesture: The current gesture translation value
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    


    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                 // 5
                Image("beans")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                    .clipped()
                
                HStack {
                    // 5
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(self.customPlace.placeLikelihood.place.name!)")
                            .font(.title)
                            .bold()
                        Text("\(self.customPlace.placeLikelihood.place.formattedAddress!)")
                            .font(.subheadline)
                            .bold()
                        Text("\(self.customPlace.placeLikelihood.place.phoneNumber ?? "no phone number")")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                    }
                    Spacer()
                    
                    Button(action: {
                        self.showingDetail.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray)
                            .frame(width: 32.0, height: 32.0)
                    }.sheet(isPresented: $showingDetail) {
                        DetailView(place: customPlace.placeLikelihood.place)
                    }
                    

                    
                }
                .padding(.horizontal)
            }
            // Add padding, corner radius and shadow with blur radius
            .padding(.bottom)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
            .shadow(radius: 5)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0) // 2
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                    }.onEnded { value in
                        // 6
                        // determine snap distance > 0.5 aka half the width of the screen
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.customPlace)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}

struct DetailView: View {
    let place: GMSPlace
    var body: some View {
        VStack(){
            Text(place.name!)
            Text(place.formattedAddress!)
        }
    }
}


// 7
/*
struct PlaceCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCardView(place: nil,
                 onRemove: { _ in
                    // do nothing
            })
            .frame(height: 400)
            .padding()
    }
 
} */
