//
//  CardView.swift
//  I Know A Spot
//
//  Created by Nathan Davenport on 12/16/20.
//

import Foundation
import SwiftUI

struct CardView: View {
    @State private var translation: CGSize = .zero
    
    // 1
    private var landmark: Landmark
    private var onRemove: (_ landmark: Landmark) -> Void
    
     // 2
    private var thresholdPercentage: CGFloat = 0.5 // when the user has draged 50% the width of the screen in either direction
    

    
    // 3
    init(landmark: Landmark, onRemove: @escaping (_ landmark: Landmark) -> Void) {
        self.landmark = landmark
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
                Image(self.landmark.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                    .clipped()
                
                HStack {
                    // 5
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(self.landmark.firstName) \(self.landmark.lastName), \(self.landmark.age)")
                            .font(.title)
                            .bold()
                        Text(self.landmark.occupation)
                            .font(.subheadline)
                            .bold()
                        //Text("\(self.landmark.mutualFriends) Mutual Friends")
                        //    .font(.subheadline)
                        //    .foregroundColor(.gray)
                        if (self.landmark.place != nil) {
                            PlaceRow(place: (self.landmark.place)!)
                            Text((self.landmark.place?.name)!)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
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
                            self.onRemove(self.landmark)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}


// 7
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(landmark: Landmark(id: 1, place: nil, firstName: "Taco", lastName: "Mac", age: 27, mutualFriends: 0, imageName: "person_1", occupation: "Insurance Agent"),
                 onRemove: { _ in
                    // do nothing
            })
            .frame(height: 400)
            .padding()
    }
}
