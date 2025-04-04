//
//  BotResponse.swift
//  foodies
//
//  Created by Bryan Bramaskara on 25/03/25.
//

import SwiftUI

func BotResponse(_ message: String) -> some View {
    HStack {
        Text(message)
            .padding()
            .background(Color(red: 1.0, green: 0.8, blue: 0.5)) // light orange-yellow
            .foregroundColor(.black)
            .cornerRadius(20)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
        Spacer()
    }
    .padding(.vertical, 4)
}

#Preview {
    BotResponse("Hello! This is a bot message.")
}
