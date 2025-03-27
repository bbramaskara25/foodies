//
//  CuisineRatingView.swift
//  foodies
//
//  Created by Eliza Vornia on 26/03/25.
//

import SwiftUI

struct CuisineRatingView: View {
    var rating: Double  // Example: 4.5
    let maxRating: Int = 5
    
    var body: some View {
        HStack (spacing: 1){
            ForEach(0..<maxRating, id: \.self) { index in
                if Double(index) + 1 <= rating {
                    Image(systemName: "star.fill")  // Full star
                        .foregroundColor(.yellow)
                } else if Double(index) + 0.5 <= rating {
                    Image(systemName: "star.leadinghalf.filled")  // Half star
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")  // Empty star
                        .foregroundColor(.gray)
                }
            }
        }
        .font(.title2)
    }
}

#Preview {
    VStack {
        CuisineRatingView(rating: 4.5)
        CuisineRatingView(rating: 3.0)
      CuisineRatingView(rating: 2.7)
       CuisineRatingView(rating: 5.0)
    }
}
