//
//  OrderHistoryDataManager.swift
//  foodies
//
//  Created by Bryan Bramaskara on 09/04/25.
//

import Foundation

class OrderHistoryDataManager {
    static let shared = OrderHistoryDataManager()

    private init() {}

    func loadOrders() -> [ChatViewModel.UserOrder] {
        // Replace this with real data loading logic, e.g., from SwiftData or UserDefaults
        return [
            ChatViewModel.UserOrder(menuItems: ["Nasi Goreng", "Teh Manis"], notes: "Pedas", total: 25000),
            ChatViewModel.UserOrder(menuItems: ["Mie Ayam"], notes: "Tanpa saos", total: 15000)
        ]
    }
}
