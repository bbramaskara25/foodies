//
//  MenuDetailPage.swift
//  foodies
//
//  Created by Eliza Vornia on 26/03/25.
//
import SwiftUI

struct CuisineCard: View {
    var menu: Cuisines
    
    var body: some View {
        VStack {
            Image(menu.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .cornerRadius(15)
            
            Text(menu.name)
                .font(.title)
            
            StarRatingView(rating: menu.rating)
                .frame(width: 50, height: 10)
            
            Text(String(format: "Rating: %.1f", menu.rating))
            Text("Location: \(menu.location)")
            
            // ✅ FIX: Gunakan rawValue untuk enum
            Text("Cuisine: \(menu.cuisine.rawValue.capitalized)")
                .font(.caption)
            
            Text("Payment Methods: \(menu.paymentMethod.joined(separator: ", "))")
                .font(.caption)
            
            Text("Price Range: \(menu.priceRange)")
                .font(.caption)
            
            Text(menu.description)
                .font(.caption)
            
          Spacer()
            
            HStack {
                
                
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
    CuisineCard(menu: Cuisines.allMenus[0])
}
