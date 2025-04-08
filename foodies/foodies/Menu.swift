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
        Menu(name: "Nasi Ayam", price: 10),
        Menu(name: "Jus Alpukat", price: 10),
        Menu(name: "Jus Apel", price: 10),
        Menu(name: "Jus Belimbing", price: 10),
        Menu( name: "Jus Buah Naga", price: 10),
        Menu( name: "Jus Jambu", price: 10),
        Menu( name: "Jus Jeruk", price: 10),
        Menu( name: "Jus Kiwi", price: 10),
        Menu( name: "Jus Tomat", price: 10),
        Menu( name: "Jus Terong Belanda", price: 10),
        Menu( name: "Jus wortel", price: 10),
        Menu( name: "Jus Buah Naga", price: 10),
        Menu( name: "Indokafe Cofeemix", price: 4),
        Menu( name: "Luwak", price: 4),
        Menu( name: "Kapal Api", price: 4),
        Menu( name: "GoodDay Merah", price: 4),
        Menu( name: "Susu", price: 5),
        Menu( name: "Nutrisari", price: 5),
        Menu( name: "Es Teh Manis", price: 5),
        Menu( name: "Es Teh Tawar", price: 3),
        Menu( name: "Teh Tawar Panas", price: 3),
        Menu( name: "Teh Manis Panas", price: 4),
        Menu( name: "Pop Mie Seduh", price: 7),
        Menu( name: "Indomeie Goreng/Kuah", price: 7),
        Menu( name: "Indomie Telor", price: 10),
        Menu( name: "Jus Buah Naga", price: 10),
        Menu( name: "Ades/Pristine", price: 4),
        Menu( name: "Ades 1,5 L", price: 6),
        Menu( name: "Sprite/Fanta/Cola 250 ml", price: 4),
        Menu( name: "Sprite/Fanta/Cola 390 ml", price: 6),
        Menu( name: "Frestea 350 ml", price: 5),
        Menu( name: "Pulpy Orange 300 ml", price: 5),
        Menu( name: "Nutriboost", price: 7),
        Menu( name: "Pocari", price: 7)
    ]
}
