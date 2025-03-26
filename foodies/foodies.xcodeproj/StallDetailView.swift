//
//  StallDetailView.swift
//  foodies
//
//  Created by Eliza Vornia on 26/03/25.
//

import SwiftUI

struct StallDetailView: View {
    var stall: Stall
    
    var body: some View {
        VStack{
            Image(stall.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .cornerRadius(15)
            
            Text(stall.name)
                .font(.title)
            StarRatingView(rating: stall.rating)
                .frame(width: 50, height: 10)
            Text(String(format: "Rating: %.1f", stall.rating))
            Text("Location: \(stall.location)")
            Text("Cuisine: \(stall.cuisine.joined(separator: ", "))")
                .font(.caption)
            Text("Payment Methods: \(stall.paymentMethod.joined(separator: ", "))")
                .font(.caption)
            
            Text("Price Range: \(stall.priceRange)")
                .font(.caption)
                
            Text(stall.details)
                .font(.caption)
            
            Spacer()
            
            HStack{
                Button {
                    // open modality
                } label: {
                    Text("View Menu")
                }
                .padding(.trailing)
                
            
                
                Button {
                    // open modality
                } label: {
                    Text("Order Now")
                }
                .padding(.leading)
            }
            

        }
    }
}

#Preview {
    StallDetailView(stall: Stall.all[0])
}
