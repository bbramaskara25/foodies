//
//  UserOrder.swift
//  foodies
//
//  Created by Bryan Bramaskara on 08/04/25.
//

// UserOrder.swift
import Foundation
import SwiftData

@Model
class UserOrder {
    var menuItems: [String]
    var notes: String
    var total: Int
    var timestamp: Date

    init(menuItems: [String], notes: String, total: Int, timestamp: Date) {
        self.menuItems = menuItems
        self.notes = notes
        self.total = total
        self.timestamp = timestamp
    }
}

struct OrderHistory: Identifiable, Hashable {
    var id = UUID()
    let stallName: String
    let items: [String]
}

