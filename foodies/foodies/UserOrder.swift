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
    var id: UUID
    var menuItems: [String] // Or you can create a MenuItem model
    var notes: String
    var total: Int
    var date: Date

    init(menuItems: [String], notes: String, total: Int) {
        self.id = UUID()
        self.menuItems = menuItems
        self.notes = notes
        self.total = total
        self.date = Date()
    }
}
