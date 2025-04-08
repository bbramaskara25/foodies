import SwiftUI

class ChatViewModel: ObservableObject {
    struct ChatMessage {
        var text: String
        var isUser: Bool
        var isOption: Bool
        var options: [String]
        var isAnswered: Bool = false
    }

    struct Stall: Identifiable {
        let id = UUID()
        let name: String
        let gop: String
        let budget: String
        let cuisine: String
    }

    @Published var chatMessages: [ChatMessage] = []
    @Published var hasStarted: Bool = false
    @Published var recommendedStalls: [Stall] = []

    private var currentQuestionIndex: Int = -1
    private let questions: [(text: String, options: [String])] = [
        ("Sekarang kamu ada di GOP berapa?", ["GOP 1", "GOP 6", "GOP 9", "Mau Explore Semua"]),
        ("Berapa budget makan kamu?", ["<20.000", "20.000-30.000", ">30.000", "Budgetnya Bebas"]),
        ("Apakah ada cuisine favorit kamu?", ["Indonesian", "Japanese", "Chinese", "Prefer not to mention"]),
        ("Berikut adalah rekomendasi dari kami, apakah kamu menyukainya?", ["Yes", "No"]),
        ("Apakah kamu menyukai aplikasi ini?", ["Yes", "No"])
    ]

    private let stalls: [Stall] = [
        Stall(name: "Nasi Padang Maknyus", gop: "GOP 1", budget: "<20.000", cuisine: "Indonesian"),
        Stall(name: "Sushi Go", gop: "GOP 6", budget: ">30.000", cuisine: "Japanese"),
        Stall(name: "Dimsum Queen", gop: "GOP 9", budget: "20.000-30.000", cuisine: "Chinese"),
        Stall(name: "Warung Bebas", gop: "GOP 1", budget: "Budgetnya Bebas", cuisine: "Indonesian"),
        Stall(name: "Donburi Senpai", gop: "GOP 6", budget: "20.000-30.000", cuisine: "Japanese")
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

            if currentQuestionIndex == 3 { // before asking if user likes the recommendation
                filterStalls()
            }
        } else {
            chatMessages.append(ChatMessage(text: "Terima kasih sudah menggunakan Foodies! 😊", isUser: false, isOption: false, options: []))
        }
    }

    func handleAnswer(_ answer: String, at index: Int) {
        chatMessages[index].isAnswered = true
        chatMessages.remove(at: index)

        if answer == "Edit previous response" {
            guard !previousAnswers.isEmpty else { return }

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

    func filterStalls() {
        var gop = ""
        var budget = ""
        var cuisine = ""

        for (questionIndex, answer) in previousAnswers {
            switch questionIndex {
            case 0: gop = answer
            case 1: budget = answer
            case 2: cuisine = answer
            default: break
            }
        }

        recommendedStalls = stalls.filter { stall in
            (gop == "Mau Explore Semua" || stall.gop == gop) &&
            (budget == "Budgetnya Bebas" || stall.budget == budget) &&
            (cuisine == "Prefer not to mention" || stall.cuisine == cuisine)
        }
    }
}
