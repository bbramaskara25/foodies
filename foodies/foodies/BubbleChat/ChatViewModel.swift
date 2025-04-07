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
        ("Sekarang kamu ada di GOP berapa?", ["GOP 1", "GOP 6", "GOP 9", "Mau Explore Semua"]),
        ("Berapa budget makan kamu?", ["<20.000", "20.000-30.000", ">30.000", "Budgetnya Bebas"]),
        ("Apakah ada cuisine favorit kamu?", ["Indonesian", "Japanese", "Chinese", "Prefer not to mention"]),
        ("Berikut adalah rekomendasi dari kami, apakah kamu menyukainya?", ["Yes", "No"]),
        ("Apakah kamu menyukai aplikasi ini?", ["Yes", "No"])
    ]

    private var previousAnswers: [(questionIndex: Int, answer: String)] = []

    func startChat() {
        hasStarted = true
        chatMessages.append(ChatMessage(text: "Halo! Selamat datang di Foodies 👋\nYuk mulai cari rekomendasi makanan buat kamu!", isUser: false, isOption: false, options: []))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.currentQuestionIndex = 0
            self.showNextQuestion()
        }
    }

    func showNextQuestion() {
        if currentQuestionIndex < questions.count {
            let question = questions[currentQuestionIndex]
            var optionsWithEdit = question.options
            if currentQuestionIndex > 0 {
                optionsWithEdit.append("Edit previous response")
            }
            chatMessages.append(ChatMessage(text: question.text, isUser: false, isOption: false, options: []))
            chatMessages.append(ChatMessage(text: "", isUser: false, isOption: true, options: optionsWithEdit))
        } else {
            chatMessages.append(ChatMessage(text: "Terima kasih sudah menggunakan Foodies! 😊", isUser: false, isOption: false, options: []))
        }
    }

    func handleAnswer(_ answer: String, at index: Int) {
        chatMessages[index].isAnswered = true
        chatMessages.remove(at: index)

        if answer == "Edit previous response" {
            guard !previousAnswers.isEmpty else { return }

            // Remove current question and next bot message if present
            if chatMessages.count >= 2 {
                let lastMessage = chatMessages.last
                let secondLastMessage = chatMessages.dropLast().last
                if let last = lastMessage, let secondLast = secondLastMessage,
                   !last.isUser && !last.isOption && !secondLast.isUser && secondLast.isOption {
                    chatMessages.removeLast(2)
                } else if let last = lastMessage, !last.isUser && !last.isOption {
                    chatMessages.removeLast()
                }
            }

            chatMessages.append(ChatMessage(text: "Kamu memilih untuk edit jawaban sebelumnya.", isUser: true, isOption: false, options: []))

            let last = previousAnswers.removeLast()
            currentQuestionIndex = last.questionIndex

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showNextQuestion()
            }
            return
        }

        chatMessages.append(ChatMessage(text: answer, isUser: true, isOption: false, options: []))
        previousAnswers.append((questionIndex: currentQuestionIndex, answer: answer))
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
                if !previousAnswers.isEmpty {
                    previousAnswers.removeLast()
                }
                currentQuestionIndex = chatMessages.prefix(realQuestionIndex).filter { !$0.isUser && !$0.isOption }.count
                showNextQuestion()
            }
        }
    }
}
