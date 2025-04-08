//
//  totalView.swift
//  foodies
//
//  Created by Eliza Vornia on 08/04/25.
//
import SwiftUI

struct TotalView: View {
    var total: Int
    var onSave: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Current Total: Rp \(total.formatted(.number.grouping(.automatic))),-")
                .font(.headline)
               

            Button(action: {
                onSave()
            }) {
                Text("Save Order")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(width: 400, height: 150)
       
        
        .shadow(radius: 1)
    }
}
#Preview {
    TotalView(total: 37500, onSave: {
        print("🛒 Order saved.")
    })
    .padding()
    .previewLayout(.sizeThatFits)
}
