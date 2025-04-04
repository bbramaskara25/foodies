//
//  ChatMessage.swift
//  foodies
//
//  Created by Bryan Bramaskara on 25/03/25.
//

import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let message: String
    let isUser: Bool
}
