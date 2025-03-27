//
//  Stall.swift
//  foodies
//
//  Created by Eliza Vornia on 26/03/25.
//

import Foundation

struct Stall: Codable, Identifiable{
    var id = UUID()
    var name: String
    var image: String
    var rating: Double
    var location: String
    var category: [String]
    var lowestPrice: Int
    var highestPrice: Int
    var paymentMethod: [String]
    var details: String
    var wasOrdered: Bool = false
    var Menu: [Menu] = []
}


extension Stall {
    static let all: [Stall] = [
        Stall(name: "Mustafa Minang", image: "Kasturi", rating: 4.5, location: "GOP 9", category: ["Noodles", "Western Food"], lowestPrice: 5, highestPrice: 10, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Ahza Snack & Beverage", image: "Kasturi", rating: 5.0, location: "GOP 9", category: ["Rice", "Western Food"], lowestPrice: 6, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Soto Pak Gembul", image: "Kasturi", rating: 5.0, location: "GOP 9", category: ["Vegetables", "Western Food"], lowestPrice: 7, highestPrice: 25, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Kedai Aneka Rasa", image: "Kasturi", rating: 5.0, location: "GOP 9", category: ["Snacks", "Western Food"], lowestPrice: 10, highestPrice: 30, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Kedai 2 Nyonya", image: "Kasturi", rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 15, highestPrice: 15, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Kantin Kasturi", image: "Kasturi", rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 20, highestPrice: 22, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Kedai Laris Manis", image: "Kasturi", rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 12, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "La Ding", image: "Kasturi", rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 11, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Mama Djempol", image: "Kasturi", rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Ikan & Bakso Bakwan Malang Josss", image: "Kasturi", rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Dapur Mimin", image: "Kasturi", rating: 5.0, location: "GOP 6", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Warkop Pais", image: "Kasturi", rating: 5.0, location: "GOP 6", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Nasi Kapau Nusantara", image: "Kasturi", rating: 5.0, location: "GOP 6", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        // padang yg rame itu tp gatau namanya
        Stall(name: "Dapur Kencana", image: "Kasturi", rating: 5.0, location: "GOP 1", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik")
    ]
}
