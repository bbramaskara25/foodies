//
//  stallsCard.swift
//  foodies
//
//  Created by Eliza Vornia on 25/03/25.
//
import Foundation
import SwiftUI

struct StallsCard: View {
    var stall: Stall
    
    var body: some View {
        HStack {
            Image(stall.images[0])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .padding(10)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(stall.name)
                        .font(.headline)
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "pin.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.orange)
                    Text(stall.location)
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "wallet.bifold.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundColor(.orange)
                    
                    Text("Rp\(stall.lowestPrice) - \(stall.highestPrice)")
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.orange)
                    Text(String(format: "%.1f", stall.rating))
                        .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    StallsCard(stall: Stall.all[0])
}
