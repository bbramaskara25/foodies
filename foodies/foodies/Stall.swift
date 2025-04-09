//
//  Stall.swift
//  foodies
//
//  Created by Eliza Vornia on 26/03/25.
//

import Foundation

class Stall: ObservableObject, Identifiable {
    let id = UUID()
    var name: String
    var images: [String]
    var rating: Double
    var location: String
    var category: [String]
    var lowestPrice: Int
    var highestPrice: Int
    @Published var wasOrdered: Bool
    var menuList: [Menu]
    var whatsAppNumber: String

    init(name: String, images: [String], rating: Double, location: String, category: [String], lowestPrice: Int, highestPrice: Int, menuList: [Menu], whatsAppNumber: String) {
        self.name = name
        self.images = images
        self.rating = rating
        self.location = location
        self.category = category
        self.lowestPrice = lowestPrice
        self.highestPrice = highestPrice
        self.wasOrdered = false
        self.menuList = menuList
        self.whatsAppNumber = whatsAppNumber
    }
}



extension Stall {
    static let all: [Stall] = [
        // sisa fotonya
        Stall(
            name: "Mustafa Minang",
            images: ["Kasturi", "padang", "Kasturi"],
            rating: 4.8,
            location: "GOP 9",
            category: ["Nasi", "Sayuran"],
            lowestPrice: 3000,
            highestPrice: 33000,
            menuList: [
                Menu(name: "Nasi + Ayam (All Variant)", price: 22000),
                Menu(name: "Nasi + Rendang", price: 25000),
                Menu(name: "Nasi + Dendeng", price: 25000),
                Menu(name: "Nasi + Gulai Tunjang", price: 33000),
                Menu(name: "Nasi + Gulai Cincang", price: 25000),
                Menu(name: "Nasi + Sambal Goreng Ati", price: 23000),
                Menu(name: "Nasi + Ikan", price: 20000),
                Menu(name: "Nasi + Perkedel", price: 15000),
                Menu(name: "Nasi + Telor", price: 15000),
                Menu(name: "Nasi + Gulai Otak", price: 25000),
                
                Menu(name: "Ayam (All Variant)", price: 15000),
                Menu(name: "Rendang", price: 18000),
                Menu(name: "Dendeng", price: 18000),
                Menu(name: "Gulai Otak", price: 18000),
                Menu(name: "Gulai Tunjang", price: 23000),
                Menu(name: "Gulai Cincang", price: 18000),
                Menu(name: "Sambal Goreng Ati", price: 13000),
                Menu(name: "Ikan", price: 15000),
                Menu(name: "Telor", price: 6000),
                Menu(name: "Perkedel", price: 6000),
                Menu(name: "Peyek Udang", price: 5000),
                Menu(name: "Kerupuk Kulit", price: 3000),
                Menu(name: "Kerupuk Kaleng", price: 3000),
                Menu(name: "Sayur", price: 3000),
                Menu(name: "Kuah", price: 3000)
            ],
            whatsAppNumber: "6285945553570"
        ),
        // sisa fotonya
        Stall(
            name: "Ahza Snack & Beverage",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 4.9,
            location: "GOP 9",
            category: ["Cemilan", "Minuman", "Mie"],
            lowestPrice: 4000,
            highestPrice: 10000,
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
                Menu( name: "Ades/Pristine", price: 4000),
                Menu( name: "Ades 1,5 L", price: 6000),
                Menu( name: "Sprite/Fanta/Cola 250 ml", price: 4000),
                Menu( name: "Sprite/Fanta/Cola 390 ml", price: 6000),
                Menu( name: "Frestea 350 ml", price: 5000),
                Menu( name: "Pulpy Orange 300 ml", price: 5000),
                Menu( name: "Nutriboost", price: 7000),
                Menu( name: "Pocari", price: 7000)
            ],
            whatsAppNumber: "6289516851555"

        ),
        // sisa fotonya
        Stall(
            name: "Kedai Aneka Rasa",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 4.7,
            location: "GOP 9",
            category: ["Mie", "Sayuran"],
            lowestPrice: 15000,
            highestPrice: 35000,
            menuList: [
                Menu(name: "Gado-gado Sayur", price: 15000),
                Menu(name: "Gado-gado Sayur + Lontong", price: 20000),
                Menu(name: "Gado-gado Sayur + Lontong + Telur", price: 25000),
                Menu(name: "Gado-gado Sayur + Nasi", price: 20000),
                Menu(name: "Gado-gado Sayur + Nasi + Telur", price: 25000),
                Menu(name: "Ketoprak + Lontong + Telur", price: 25000),
                Menu(name: "Ketoprak + Lontong", price: 20000),
                Menu(name: "Ketoprak", price: 15000),
                
                Menu(name: "Mie Ayam Komplit", price: 25000),
                Menu(name: "Mie Ayam Bakso", price: 25000),
                Menu(name: "Mie Ayam Pangsit", price: 25000),
                Menu(name: "Mie Ayam Rica", price: 25000),
                Menu(name: "Mie Ayam Polos", price: 20000),
                Menu(name: "Mie Ayam Dino", price: 30000),
                Menu(name: "Mie Ayam Dino Komplit", price: 35000),
                Menu(name: "Mie Yamin Komplit", price: 25000),
                Menu(name: "Mie Yamin Bakso", price: 25000),
                Menu(name: "Mie Yamin Pangsit", price: 25000),
                Menu(name: "Mie Yamin Rica", price: 25000),
                Menu(name: "Mie Lebar", price: 25000),
                Menu(name: "Kwetiau Kuah Bakso", price: 25000),
                Menu(name: "Kwetiau Kuah Pangsit", price: 25000),
                Menu(name: "Kwetiau Kuah Rica", price: 25000),
                Menu(name: "Bihun Kuah Bakso", price: 25000),
                Menu(name: "Bihun Kuah Pangsit", price: 25000),
                Menu(name: "Bihun Kuah Rica", price: 25000)
            ],
            whatsAppNumber: "6282116508399"
        ),
//        // belom semua kecuali nomor
//        Stall(
//            name: "Kantin Kasturi",
//            images: ["Kasturi", "Kasturi", "Kasturi"],
//            rating: 5.0,
//            location: "GOP 9",
//            category: ["Nasi", "Sayuran", "Mie", "Cemilan"],
//            lowestPrice: 10000,
//            highestPrice: 15000,
//            menuList: [
//                Menu(name: "Nasi Goreng", price: 10),
//                Menu(name: "Nasi Goreng", price: 12),
//                Menu(name: "Nasi Goreng", price: 14),
//                Menu( name: "Nasi Goreng", price: 15)
//            ],
//            whatsAppNumber: "6281380770081"
//        ),
        // sisa foto
        Stall(
            name: "Kedai Laris Manis",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 4.8,
            location: "GOP 9",
            category: ["Nasi", "Sayuran"],
            lowestPrice: 4000,
            highestPrice: 10000,
            menuList: [
                Menu(name: "Ayam Bumbu Bali", price: 7000),
                Menu(name: "Ikan Sarden", price: 8000),
                Menu(name: "Sayur Tumis", price: 4000),
                Menu(name: "Tempe Orek", price: 4000),
                Menu(name: "Ayam Popcorn", price: 7000),
                Menu(name: "Telur Dadar", price: 5000),
                Menu(name: "Telur Ceplok", price: 5000),
                Menu(name: "Telur Balado", price: 5000),
                Menu(name: "Ayam Kecombrang", price: 7000),
                Menu(name: "Ayam Semur Kentang", price: 7000),
                Menu(name: "Ayam Asam Manis", price: 7000),
                Menu(name: "Ayam Salted Egg", price: 10000),
                Menu(name: "Nasi Putih", price: 5000),
            ],
            whatsAppNumber: "‪628126001285‬"
        ),
        // sisa foto
        Stall(
            name: "La Ding",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 4.6,
            location: "GOP 9",
            category: ["Nasi", "Mie", "Cemilan", "Berkuah", "Minuman"],
            lowestPrice: 3000,
            highestPrice: 34000,
            menuList: [
                Menu(name: "Soto Mie Bogor", price: 20000),
                Menu(name: "Sop Daging", price: 27000),
                Menu(name: "Sop Iga", price: 27000),
                Menu(name: "Somay", price: 6000),
                Menu(name: "Nasi 1", price: 5000),
                Menu(name: "Nasi 1/2", price: 3000),
                Menu(name: "Nasi Uduk (Tempe Orek, Tahu, Telur, Bihun)", price: 17000),
                Menu(name: "Kerupuk Bangka", price: 5000),
                Menu(name: "Bawang Goreng", price: 34000),
                Menu(name: "Teh Tawar Hangat", price: 2000),
                Menu(name: "Teh Manis Hangat", price: 4000)
            ],
            whatsAppNumber: "6282241599564"
        ),
//        // belom semua kecuali nomor
//        Stall(
//            name: "Mama Djempol",
//            images: ["Kasturi", "Kasturi", "Kasturi"],
//            rating: 4.7,
//            location: "GOP 9",
//            category: ["Nasi", "Sayuran", "Mie", "Cemilan"],
//            lowestPrice: 10000,
//            highestPrice: 15000,
//            menuList: [
//                Menu(name: "Nasi Goreng", price: 10),
//                Menu(name: "Nasi Goreng", price: 12),
//                Menu(name: "Nasi Goreng", price: 14),
//                Menu( name: "Nasi Goreng", price: 15)
//            ],
//            whatsAppNumber: "6282258937032"
//        ),
        // sisa foto
        Stall(
            name: "Ikan & Bakso Bakwan Malang Josss",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 4.8,
            location: "GOP 9",
            category: ["Berkuah"],
            lowestPrice: 3000,
            highestPrice: 28000,
            menuList: [
                Menu(name: "Bakso Urat", price: 18000),
                Menu(name: "Bakso Rawit", price: 18000),
                Menu(name: "Bakso Telur", price: 18000),
                Menu(name: "Paket Komplit Bakso", price: 28000),
                Menu(name: "Paket Komplit Bakwan malang", price: 15000),
                Menu(name: "1 Pangsit Goreng", price: 3000),
                Menu(name: "1 Pangsit Rebus", price: 3000),
                Menu(name: "1 Bakso Goreng", price: 3000),
                Menu(name: "1 Risol", price: 3000),
                Menu(name: "1 Tahu Putih", price: 3000),
                Menu(name: "1 Tahu Coklat", price: 3000),
                Menu(name: "1 Simoay Kecil", price: 3000),
                Menu(name: "1 Pilus", price: 3000)
            ],
            whatsAppNumber: "6287818181297"
        ),
        // sisa foto
        Stall(
            name: "Dapur Mimin",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 4.8,
            location: "GOP 6",
            category: ["Cemilan", "Sayuran", "Nasi"],
            lowestPrice: 2000,
            highestPrice: 27000,
            menuList: [
                Menu(name: "Gorengan", price: 2000),
                Menu(name: "Jamur Cabe Garam", price: 5000),
                Menu(name: "Telur Kecap", price: 6000),
                Menu(name: "Tempe Orek", price: 5000),
                Menu(name: "Gado-gado", price: 17000),
                Menu(name: "Gado-gado + Lontong", price: 22000),
                Menu(name: "Ketoprak", price: 19000),
                Menu(name: "Ketoprak Mie + Telur", price: 27000),
                Menu(name: "Ketoprak Mie", price: 22000),
                Menu(name: "Nasi Kebuli/Briyani", price: 18000),
                Menu(name: "Siomay ", price: 20000),
                Menu(name: "Ayam", price: 18000),
                Menu(name: "Sate Ayam Manis 1 Tusuk", price: 8000),
                Menu(name: "Mie", price: 5000),
                Menu(name: "Bihun", price: 5000),
                Menu(name: "Kwetiau", price: 5000),
                Menu(name: "Sayuran", price: 5000)
            ],
            whatsAppNumber: "628170155576"
        ),
        // sisa foto
        Stall(
            name: "Warkop Pais",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 4.7,
            location: "GOP 6",
            category: ["Cemilan", "Sayuran", "Mie"],
            lowestPrice: 3000,
            highestPrice: 14000,
            menuList: [
                Menu(name: "Lontong Sayur", price: 12000),
                Menu(name: "Nasi Uduk", price: 12000),
                Menu(name: "Nasi Goreng", price: 12000),
                Menu(name: "Bihun Goreng", price: 5000),
                Menu(name: "Bubur Kacang Ijo", price: 7000),
                Menu(name: "Jus", price: 10000),
                Menu(name: "Indomie + Telur", price: 12000),
                Menu(name: "Indomie", price: 8000),
                Menu(name: "Indomie Jumbo + Telur", price: 14000),
                Menu(name: "Indomie Jumbo", price: 11000),
                Menu(name: "Gorengan", price: 3000)
            ],
            whatsAppNumber: "6287755316269"
        ),
        // sisa foto
        Stall(
            name: "Nasi Kapau Nusantara",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 5.0,
            location: "GOP 6",
            category: ["Nasi"],
            lowestPrice: 3500,
            highestPrice: 28000,
            menuList: [
                Menu(name: "Ayam Gulai", price: 20000),
                Menu(name: "Ayam Pop", price: 20000),
                Menu(name: "Ayam Bakar", price: 20000),
                Menu(name: "Ayam Goreng", price: 20000),
                Menu(name: "Ayam Kemangi", price: 20000),
                Menu(name: "Ayam Cabe Ijo", price: 20000),
                Menu(name: "Cincang Sapi", price: 21000),
                Menu(name: "Dendeng Batokok", price: 21000),
                Menu(name: "Gulai Otak", price: 20000),
                Menu(name: "Ikan Bawal Bakar", price: 19000),
                Menu(name: "Ikan Kembung Bakar", price: 17000),
                Menu(name: "Nasi Putih", price: 8500),
                Menu(name: "Paru", price: 19000),
                Menu(name: "Perkedel", price: 8000),
                Menu(name: "Rendang", price: 22000),
                Menu(name: "Sambal GR Kentang Ati", price: 18000),
                Menu(name: "Sayuran", price: 8000),
                Menu(name: "Tambusu", price: 18000),
                Menu(name: "Telur Gulai", price: 9000),
                Menu(name: "Telur Balado", price: 9000),
                Menu(name: "Telur Dadar", price: 9000),
                Menu(name: "Tempe", price: 3500),
                Menu(name: "Tahu", price: 3500),
                Menu(name: "Tempe Teri Terong", price: 11000),
                Menu(name: "Terong Balado", price: 7000),
                Menu(name: "Tongkol Asam Padeh", price: 18000),
                Menu(name: "Tunjang / Kikil", price: 23000),

                Menu(name: "Nasi Paket Sayur", price: 13000),
                Menu(name: "Nasi Paket Teri Terong Tempe", price: 18000),
                Menu(name: "Nasi Paket Telur Gulai", price: 19000),
                Menu(name: "Nasi Paket Telur Balado", price: 19000),
                Menu(name: "Nasi Paket Telur Dadar", price: 19000),
                Menu(name: "Nasi Paket Tongkol Asam Padeh", price: 25000),
                Menu(name: "Nasi Paket Tunjang", price: 28000),
                Menu(name: "Nasi Paket Kikil", price: 28000),
                Menu(name: "Nasi Paket Tambusu", price: 26000),
                Menu(name: "Nasi Paket Usus", price: 26000),
                Menu(name: "Nasi Paket Terong Balado", price: 15000),
                Menu(name: "Nasi Paket Ayam Kemangi", price: 26000),
                Menu(name: "Nasi Paket Ayam Cabe Ijo", price: 26000),
                Menu(name: "Nasi Paket Ayam Goreng", price: 26000),
                Menu(name: "Nasi Paket Ayam Bakar", price: 26000),
                Menu(name: "Nasi Paket Ayam Pop", price: 26000),
                Menu(name: "Nasi Paket Ayam Gulai", price: 26000),
                Menu(name: "Nasi Paket Cincang Sapi", price: 28000),
                Menu(name: "Nasi Paket Dendeng Batokok", price: 27000),
                Menu(name: "Nasi Paket Dendeng Kering", price: 26500),
                Menu(name: "Nasi Paket Gulai Otak", price: 26000),
                Menu(name: "Nasi Paket Ikan Bawal Bakar", price: 25000),
                Menu(name: "Nasi Paket Ikan Kembung Bakar", price: 25000),
                Menu(name: "Nasi Paket Paru", price: 25000),
                Menu(name: "Nasi Paket Perkedel", price: 16000),
                Menu(name: "Nasi Paket Rendang", price: 27000),
                Menu(name: "Nasi Paket Sambal GR Kentang Ati", price: 24000)
            ],
            whatsAppNumber: "6281386330339"
        ),
        // sisa foto
        Stall(
            name: "Dapur Kencana",
            images: ["Kasturi", "Kasturi", "Kasturi"],
            rating: 5.0,
            location: "GOP 1",
            category: ["Nasi", "Cemilan", "Berkuah", "Sayuran"],
            lowestPrice: 6000,
            highestPrice: 44000,
            menuList: [
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
                Menu(name: "Hot/Ice Coffee drip", price: 15000),
            ],
            whatsAppNumber: "6281218154065"
        )
    ]
}
