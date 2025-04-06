//
//  ChatViewModel.swift
//  foodies
//
//  Created by Eliza Vornia on 04/04/25.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    struct ChatMessage {
        var text: String
        var isUser: Bool
        var isOption: Bool
        var options: [String]
        var isAnswered: Bool = false
    }
    
    @Published var chatMessages: [ChatMessage] = []
    @Published var hasStarted: Bool = false
    private var currentQuestionIndex: Int = -1
    private let questions: [(text: String, options: [String])] = [
        ("Sekarang kamu ada di GOP berapa?", ["GOP 1", "GOP 6", "GOP 9", "Prefer not to mention"]),
        ("Berapa budget makan kamu?", ["<20.000", "20.000-30.000", ">30.000", "Prefer not to mention"]),
        ("Apakah ada cuisine favorit kamu?", ["Indonesian", "Japanese", "Chinese", "Prefer not to mention"]),
        ("Berikut adalah rekomendasi dari kami, apakah kamu menyukainya?", ["Yes", "No"]),
        ("Apakah kamu menyukai aplikasi ini?", ["Yes", "No"])
    ]
    
    func startChat() {
        hasStarted = true
        currentQuestionIndex = 0
        showNextQuestion()
    }
    
    func showNextQuestion() {
        if currentQuestionIndex < questions.count {
            let question = questions[currentQuestionIndex]
            chatMessages.append(ChatMessage(text: question.text, isUser: false, isOption: false, options: []))
            chatMessages.append(ChatMessage(text: "", isUser: false, isOption: true, options: question.options))
        }
    }
    
    func handleAnswer(_ answer: String, at index: Int) {
        chatMessages[index].isAnswered = true
        chatMessages.remove(at: index) // Menghapus opsi setelah user memilih
        chatMessages.append(ChatMessage(text: answer, isUser: true, isOption: false, options: []))
        currentQuestionIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showNextQuestion()
        }
    }
    
    func undoAnswer(for index: Int) {
        if index > 0 && index < chatMessages.count {
            let previousQuestionIndex = chatMessages.prefix(index).lastIndex(where: { !$0.isUser && !$0.isOption })
            if let realQuestionIndex = previousQuestionIndex {
                chatMessages.removeSubrange(realQuestionIndex..<chatMessages.count)
                currentQuestionIndex = realQuestionIndex / 2
                showNextQuestion()
            }
        }
    }
}
