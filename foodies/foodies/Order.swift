//
//  Order.swift
//  foodies
//
//  Created by Eliza Vornia on 27/03/25.
//

import Foundation
import SwiftData

@Model
class Order {
    var menuName: String
    var quantity: Int
    var price: Int

    init(menuName: String, quantity: Int, price: Int) {
        self.menuName = menuName
        self.quantity = quantity
        self.price = price
    }
}
