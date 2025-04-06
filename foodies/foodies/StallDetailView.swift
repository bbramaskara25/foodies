//
//  StallDetailView.swift
//  foodies
//
//  Created by Eliza Vornia on 26/03/25.
//
import SwiftUI

struct StallDetailView: View {
    var stall: Stall
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 10) {
            TabView {
                ForEach(stall.images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .shadow(radius: 5)
                }
            }
            .frame(height: 250)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle())
            
            Text(stall.name)
                .font(.title)
            StarRatingView(rating: stall.rating)
                .frame(width: 50, height: 10)
            Text(String(format: "Rating: %.1f", stall.rating))
            Text("Location: \(stall.location)")
            Text("Category: \(stall.category.joined(separator: ", "))")
                .font(.caption)
            Text("Payment Methods: \(stall.paymentMethod.joined(separator: ", "))")
                .font(.caption)
            Text("Price Range: \(stall.lowestPrice) - \(stall.highestPrice)k")
                .font(.caption)
            Text(stall.details)
                .font(.caption)
            
            Spacer()
            
            HStack {
                // Passing the formatted menu list to MenuPage
                NavigationLink(destination: MenuPage(menuList: stall.menuList.map { ($0.name, Int($0.price)) })) {
                    Text("View Menu")
                        .padding()
                        .foregroundColor(.blue)
                }
                .padding(.trailing)
                
                Button {
                    // Implement order action
                } label: {
                    Text("Order Now")
                        .padding()
                        .foregroundColor(.blue)
                }
                .padding(.leading)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {
            //   presentationMode.wrappedValue.dismiss() // Kembali ke halaman sebelumnya
        }) {
           // Text("Back")
        })
    }
}

#Preview {
    NavigationStack {
        StallDetailView(stall: Stall.all[0])
    }
}
