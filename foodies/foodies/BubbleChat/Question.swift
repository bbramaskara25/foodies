//
//  Question.swift
//  foodies
//
//  Created by Eliza Vornia on 04/04/25.
//

import Foundation

struct Question: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let options: [String]
}



let sampleQuestions: [Question] = [
    Question(text: "Sekarang kamu ada di GOP berapa?", options: ["GOP 1", "GOP 6", "GOP 9", "Mau Explore Semua"]),
    Question(text: "Berapa budget makan kamu?", options: ["<20.000", "20.000-30.000", ">30.000", "Budgetnya Bebas"]),
    Question(text: "Apakah ada cuisine favorit kamu?", options: ["Indonesian", "Japanese", "Chinese", "Prefer not to mention"]),
    Question(text: "Berikut adalah rekomendasi dari kami, apakah kamu menyukainya?", options: ["Yes", "No"]),
    Question(text: "Apakah kamu menyukai aplikasi ini?", options: ["Yes", "No"])
]

