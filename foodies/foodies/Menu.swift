//
//  Menu.swift
//  foodies
//
//  Created by Eliza Vornia on 26/03/25.
//

import Foundation
struct Menu: Codable{
    var name: String
    var price: Double
}

extension Menu {
    static let all: [Menu] = [
        Menu(name: "Nasi Goreng", price: 15),
        Menu(name: "Nasi Sapi", price: 20),
        Menu(name: "Nasi Padang", price: 25),
        Menu(name: "Nasi Bebek", price: 30),
        Menu(name: "Nasi Ayam", price: 10)
    ]
}
