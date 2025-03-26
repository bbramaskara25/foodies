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
    var cuisine: [String]
    var priceRange: String
    var paymentMethod: [String]
    var details: String
    var wasOrdered: Bool = false
    var Menu: [Menu] = []
}

extension Stall {
    static let all: [Stall] = [
        Stall(name: "Mustafa Minang", image: "Kasturi", rating: 4.5, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Ahza Snack & Beverage", image: "Kasturi", rating: 5.0, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Soto Pak Gembul", image: "Kasturi", rating: 5.0, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Kedai Aneka Rasa", image: "Kasturi", rating: 5.0, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Kedai 2 Nyonya", image: "Kasturi", rating: 5.0, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Kantin Kasturi", image: "Kasturi", rating: 5.0, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Kedai Laris Manis", image: "Kasturi", rating: 5.0, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "La Ding", image: "Kasturi", rating: 5.0, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Mama Djempol", image: "Kasturi", rating: 5.0, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Ikan & Bakso Bakwan Malang Josss", image: "Kasturi", rating: 5.0, location: "GOP 9", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Dapur Mimin", image: "Kasturi", rating: 5.0, location: "GOP 6", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Warkop Pais", image: "Kasturi", rating: 5.0, location: "GOP 6", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        Stall(name: "Nasi Kapau Nusantara", image: "Kasturi", rating: 5.0, location: "GOP 6", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik"),
        // padang yg rame itu tp gatau namanya
        Stall(name: "Dapur Kencana", image: "Kasturi", rating: 5.0, location: "GOP 1", cuisine: ["Indonesian Food", "Western Food"], priceRange: "5k-20k", paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik")
    ]
}
    
        
        
//                (stallName: "Kasturi", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "Kedai Laris Manis", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "LaDing", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "Mama Djempol", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "Bakso Bakwan Malang & Ikan Josss", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "Ahz Snack & Beverage", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "Masakan Padang Mustafa Minang", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "Kedai 2 Nyonya", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "Soto Pak Gembul", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "Kedai Aneka Rasa", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k"),
//                (stallName: "Dapur Kencana", imageName: "Kasturi", stallLocation: "GOP 1", foodPrice:"5k-20k"),
//                (stallName: "Dapur Mimin", imageName: "Kasturi", stallLocation: "GOP 6", foodPrice:"5k-20k"),
//                (stallName: "Nasi Kapau Nusantara", imageName: "Kasturi", stallLocation: "GOP 9", foodPrice:"5k-20k")

