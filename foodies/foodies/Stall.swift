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
    var images: [String]
    var rating: Double
    var location: String
    var category: [String]
    var lowestPrice: Int
    var highestPrice: Int
    var paymentMethod: [String]
    var details: String
    var wasOrdered: Bool = false
    var menuList: [Menu] = [] //menyimpan daftar menu spesifik setiap stall
    var whatsAppNumber: String
}


extension Stall {
    static let all: [Stall] = [
        Stall(
            name: "Mustafa Minang",
            images: ["Kasturi", "padang", "Kasturi"],
            rating: 4.5, location: "GOP 9", category: ["Noodles", "Western Food"],
            lowestPrice: 5,
            highestPrice: 10,
            paymentMethod: ["Cash", "QR", "Transfer"],
            details: "loremkdsfjik",
            menuList: [
                Menu(name: "Nasi Goreng", price: 10000),
                Menu(name: "Nasi Aja", price: 12000),
                Menu(name: "Nasi Gado-Gado", price: 14000),
                Menu( name: "Nasi Ketupat", price: 15000)
            ],
            whatsAppNumber: "6287762149023"
        ),
        Stall(
            name: "Ahza Snack & Beverage",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 5.0,
            location: "GOP 9",
            category: ["Rice", "Western Food"],
            lowestPrice: 6,
            highestPrice: 20,
            paymentMethod: ["Cash", "QR", "Transfer"],
            details: "loremkdsfjik",
            menuList: [
                Menu(name: "Jus Alpukat", price: 10000),
                Menu(name: "Jus Apel", price: 10000),
                Menu(name: "Jus Belimbing", price: 10000),
                Menu( name: "Jus Buah Naga", price: 10000),
                Menu( name: "Jus Jambu", price: 10000),
                Menu( name: "Jus Jeruk", price: 10000),
                Menu( name: "Jus Kiwi", price: 10000),
                Menu( name: "Jus Tomat", price: 10000),
                Menu( name: "Jus Terong Belanda", price: 10000),
                Menu( name: "Jus wortel", price: 10000),
                Menu( name: "Jus Buah Naga", price: 10000),
                Menu( name: "Indokafe Cofeemix", price: 4000),
                Menu( name: "Luwak", price: 4000),
                Menu( name: "Kapal Api", price: 4000),
                Menu( name: "GoodDay Merah", price: 4000),
                Menu( name: "Susu", price: 5000),
                Menu( name: "Nutrisari", price: 5000),
                Menu( name: "Es Teh Manis", price: 5000),
                Menu( name: "Es Teh Tawar", price: 3000),
                Menu( name: "Teh Tawar Panas", price: 3000),
                Menu( name: "Teh Manis Panas", price: 4000),
                Menu( name: "Pop Mie Seduh", price: 7000),
                Menu( name: "Indomeie Goreng/Kuah", price: 7000),
                Menu( name: "Indomie Telor", price: 10000),
                Menu( name: "Jus Buah Naga", price: 10000),
                Menu( name: "Ades/Pristine", price: 4000),
                Menu( name: "Ades 1,5 L", price: 6000),
                Menu( name: "Sprite/Fanta/Cola 250 ml", price: 4000),
                Menu( name: "Sprite/Fanta/Cola 390 ml", price: 6000),
                Menu( name: "Frestea 350 ml", price: 5000),
                Menu( name: "Pulpy Orange 300 ml", price: 5000),
                Menu( name: "Nutriboost", price: 7000),
                Menu( name: "Pocari", price: 7000)
            ],
            whatsAppNumber: "6287755316269"

        ),
        Stall(name: "Soto Pak Gembul", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 9", category: ["Vegetables", "Western Food"], lowestPrice: 7, highestPrice: 25, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "6287762149023"

             ),
        Stall(name: "Kedai Aneka Rasa", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 9", category: ["Snacks", "Western Food"], lowestPrice: 10, highestPrice: 30, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "6287755316269"

             ),
        Stall(name: "Kedai 2 Nyonya", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 15, highestPrice: 15, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "6287755316269"
),
        Stall(name: "Kantin Kasturi", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 20, highestPrice: 22, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "6287755316269"
),
        Stall(name: "Kedai Laris Manis", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 12, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Chicken Salted Egg Rice+Egg", price: 20000),
            Menu(name: "Rice Bowl Chicken Yakiniku+Egg", price: 16000),
            Menu(name: "Rice Bowl Cumi Pete", price: 16000),
            Menu( name: "Rice Bowl Chicken Pop Corn", price: 16000)
        ],
              whatsAppNumber: "6287755316269"
),
        Stall(name: "La Ding", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 11, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "6287755316269"
),
        Stall(name: "Mama Djempol", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "66287755316269"
),
        Stall(name: "Ikan & Bakso Bakwan Malang Josss", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 9", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "6287755316269"
),
        Stall(name: "Dapur Mimin", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 6", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "6287755316269"
),
        Stall(name: "Warkop Pais", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 6", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "6287755316269"
),
        Stall(name: "Nasi Kapau Nusantara", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 6", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Goreng", price: 10),
            Menu(name: "Nasi Goreng", price: 12),
            Menu(name: "Nasi Goreng", price: 14),
            Menu( name: "Nasi Goreng", price: 15),
        ],
              whatsAppNumber: "6287755316269"
),
        // padang yg rame itu tp gatau namanya
        Stall(name: "Dapur Kencana", images: ["Kasturi", "Kasturi", "Kasturi"], rating: 5.0, location: "GOP 1", category: ["Indonesian Food", "Western Food"], lowestPrice: 5, highestPrice: 20, paymentMethod: ["Cash", "QR", "Transfer"], details: "loremkdsfjik",  menuList: [
            Menu(name: "Nasi Putih", price: 6000),
            Menu(name: "Nasi Uduk", price: 8000),
            Menu(name: "Aneka Olahan Telur", price: 8500),
            Menu(name: "Aneka Olahan Sayur", price: 6500),
            Menu(name: "Aneka Olahan Ayam/Ikan", price: 13500),
            Menu(name: "Aneka Olahan Daging Sapi/Cumi/Udang", price: 18500),
            Menu(name: "Aneka Gorengan", price: 3500),
            Menu(name: "Aneka Semur Kentang/Tahu", price: 5000),
            Menu(name: "Bakmie Ayam Pangsit", price: 20000),
            Menu(name: "Beef Sandwich", price: 24000),
            Menu(name: "Bubur Jepang", price: 17000),
            Menu(name: "Nasi Uduk Telur Balado", price: 20000),
            Menu(name: "Gado-Gado", price: 23000),
            Menu(name: "Sate Ayam", price: 27000),
            Menu(name: "Nasi Goreng Spesial", price: 25000),
            Menu(name: "Bakmie Goreng Spesial", price: 29000),
            Menu(name: "Bakso Sapi", price: 23000),
            Menu(name: "Spring Roll", price: 9000),
            Menu(name: "Chicken Ball", price: 15000),
            Menu(name: "Martabak Goreng", price: 14000),
            Menu(name: "Japchae", price: 15000),
            Menu(name: "Tteokbokki", price: 14000),
            Menu(name: "Siomai", price: 15000),
            Menu(name: "Corndog Sosis", price: 7000),
            Menu(name: "Apple Pie", price: 7500),
            Menu(name: "French Fries", price: 19000),
            Menu(name: "Chicken Crispy Original", price: 17000),
            Menu(name: "Chicken Crispy Orange/Gochujang", price: 20000),
            Menu(name: "Soto Ayam Bening ALA", price: 21000),
            Menu(name: "Soto Ayam Bening SET", price: 26000),
            Menu(name: "Chicken Katsu ALA", price: 23000),
            Menu(name: "Chicken Katsu SET", price: 28000),
            Menu(name: "Sop Daging ALA", price: 34000),
            Menu(name: "Sop Daging SET", price: 39000),
            Menu(name: "Tongseng Daging Sapi ALA", price: 28000),
            Menu(name: "Tongseng Daging Sapi ALA", price: 33000),
            Menu(name: "Soto Daging Garang Asem ALA", price: 39000),
            Menu(name: "Soto Daging Garang Asem SET", price: 44000),
            Menu(name: "Soto Betawi Ayam ALA", price: 22000),
            Menu(name: "Soto Betawi Ayam SET", price: 27000),
            Menu(name: "Soto Betawi Daging ALA", price: 31000),
            Menu(name: "Soto Betawi Ayam SET", price: 36000),
            Menu(name: "Lontong Sayur", price: 18000),
            Menu(name: "American Breakfast", price: 29000),
            Menu(name: "Sandwich Ragout", price: 19000),
            Menu(name: "Es Teh/Panas Tawar", price: 5000),
            Menu(name: "Es Teh/Panas Manis", price: 7000),
            Menu(name: "Es Ocha/Panas", price: 5000),
            Menu(name: "Air Mineral", price: 5000),
            Menu(name: "Hot/Ice Coffee Tubruk", price: 8000),
            Menu(name: "ot/Ice Coffee drip", price: 15000),
        ],
              whatsAppNumber: "6287755316269"
)
    ]
}
