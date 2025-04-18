import SwiftUI
import Foundation

class ChatMessage: Identifiable, ObservableObject {
    let id = UUID()
    let text: String
    let isUser: Bool
    let isOption: Bool
    @Published var isAnswered: Bool
    let options: [String]

    init(text: String, isUser: Bool, isOption: Bool, isAnswered: Bool = false, options: [String]) {
        self.text = text
        self.isUser = isUser
        self.isOption = isOption
        self.isAnswered = isAnswered
        self.options = options
    }
}

class ChatViewModel: ObservableObject {
    struct Stall: Identifiable {
        let id = UUID()
        let name: String
        let gop: [String]
        let budget: [String]
        let cuisine: [String]
    }

    @Published var chatMessages: [ChatMessage] = []
    @Published var hasStarted: Bool = false
    @Published var recommendedStalls: [Stall] = []
    @Published var showStallNavigationButton: Bool = false
    @Published var showRecommendations: Bool = false


    private var currentQuestionIndex: Int = -1
    private var previousAnswers: [(questionIndex: Int, answer: String)] = []

    private let questions: [(text: String, options: [String])] = [
        ("Sekarang kamu ada di GOP berapa?", ["GOP 1", "GOP 6", "GOP 9", "Bebas Di Mana Aja"]),
        ("Berapa budget makan kamu?", ["<Rp 20.000", "Rp 20.000 - Rp 30.000", ">Rp 30.000", "Budgetnya Bebas"]),
        ("Apakah ada cuisine favorit kamu?", ["Nasi", "Mie", "Berkuah", "Cemilan", "Sayuran", "Minuman", "Apa Aja"]),
        ("Berikut adalah rekomendasi dari kami, apakah kamu menyukainya?", ["Ya, Sesuai Dengan Saya", "Kurang Pas Nih"])
    ]

    public var allStalls: [Stall] = [
        Stall(name: "Mustafa Minang", gop: ["GOP 9", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Rp 20.000 - Rp 30.000", ">Rp 30.000", "Budgetnya Bebas"], cuisine: ["Nasi", "Sayuran", "Apa Aja"]),
        Stall(name: "Ahza Snack & Beverage", gop: ["GOP 9", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Budgetnya Bebas"], cuisine: ["Cemilan", "Minuman", "Mie", "Apa Aja"]),
        Stall(name: "Kedai Aneka Rasa", gop: ["GOP 9", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Rp 20.000 - Rp 30.000", ">Rp 30.000", "Budgetnya Bebas"], cuisine: ["Mie", "Sayuran", "Apa Aja"]),
        Stall(name: "Kantin Kasturi", gop: ["GOP 9", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Budgetnya Bebas"], cuisine: ["Nasi", "Sayuran", "Mie", "Cemilan", "Apa Aja"]),
        Stall(name: "Kedai Laris Manis", gop: ["GOP 9", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Budgetnya Bebas"], cuisine: ["Nasi", "Cemilan", "Apa Aja"]),
        Stall(name: "La Ding", gop: ["GOP 9", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Rp 20.000 - Rp 30.000", ">Rp 30.000", "Budgetnya Bebas"], cuisine: ["Nasi", "Mie", "Cemilan", "Berkuah", "Minuman", "Apa Aja"]),
        Stall(name: "Mama Djempol", gop: ["GOP 9", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Budgetnya Bebas"], cuisine: ["Nasi", "Sayuran", "Mie", "Cemilan", "Apa Aja"]),
        Stall(name: "Ikan & Bakso Bakwan Malang Josss", gop: ["GOP 9", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Rp 20.000 - Rp 30.000", "Budgetnya Bebas"], cuisine: ["Berkuah", "Apa Aja"]),
        Stall(name: "Dapur Mimin", gop: ["GOP 6", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Rp 20.000 - Rp 30.000", "Budgetnya Bebas"], cuisine: ["Cemilan", "Sayuran", "Nasi", "Apa Aja"]),
        Stall(name: "Warkop Pais", gop: ["GOP 6", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Budgetnya Bebas"], cuisine: ["Cemilan", "Sayuran", "Mie", "Apa Aja"]),
        Stall(name: "Nasi Kapau Nusantara", gop: ["GOP 6", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Rp 20.000 - Rp 30.000", "Budgetnya Bebas"], cuisine: ["Nasi", "Apa Aja"]),
        Stall(name: "Dapur Kencana", gop: ["GOP 1", "Bebas Di Mana Aja"], budget: ["<Rp 20.000", "Rp 20.000 - Rp 30.000", ">Rp 30.000", "Budgetnya Bebas"], cuisine: ["Nasi", "Cemilan", "Berkuah", "Sayuran", "Apa Aja"]),
    ]

    func startChat() {
        chatMessages = []
        hasStarted = true
        currentQuestionIndex = 0
        previousAnswers = []
        showStallNavigationButton = false
        showRecommendations = false

        chatMessages.append(ChatMessage(text: "Halo! Selamat datang di Foodies 👋\nYuk mulai cari rekomendasi makanan buat kamu!", isUser: false, isOption: false, options: []))

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestion()
        }
    }
    
    func resetChat() {
        hasStarted = false
        chatMessages.removeAll()
        recommendedStalls.removeAll()
        showRecommendations = false
        showStallNavigationButton = false
    }

    func showNextQuestion() {
        if currentQuestionIndex == 3 {
            let location = previousAnswers.first(where: { $0.questionIndex == 0 })?.answer
            let budget = previousAnswers.first(where: { $0.questionIndex == 1 })?.answer
            let cuisine = previousAnswers.first(where: { $0.questionIndex == 2 })?.answer
            filterStalls(location: location, budget: budget, cuisine: cuisine)

            if recommendedStalls.isEmpty {
                chatMessages.append(ChatMessage(text: "Maaf, kami tidak menemukan rekomendasi sesuai pilihan kamu 😢", isUser: false, isOption: false, options: []))
                showStallNavigationButton = true
                showRecommendations = false
            } else {
                showRecommendations = true
                let recommendedNames = recommendedStalls.map { "• \($0.name)" }.joined(separator: "\n")
                chatMessages.append(ChatMessage(text: "Berikut rekomendasinya:\n\(recommendedNames)", isUser: false, isOption: false, options: []))
                let question = questions[currentQuestionIndex]
                var optionsWithExtras = question.options
                optionsWithExtras.append("Ganti Pilihan Sebelumnya")
                optionsWithExtras.append("Ulang dari Awal")
                chatMessages.append(ChatMessage(text: question.text, isUser: false, isOption: false, options: []))
                chatMessages.append(ChatMessage(text: "", isUser: false, isOption: true, options: optionsWithExtras))
            }
            return
        }

        guard currentQuestionIndex < questions.count else {
            chatMessages.append(ChatMessage(text: "Terima kasih sudah menggunakan Foodies! 😊", isUser: false, isOption: false, options: []))
            return
        }

        let question = questions[currentQuestionIndex]
        var optionsWithExtras = question.options
        if currentQuestionIndex > 0 {
            optionsWithExtras.append("Ganti Pilihan Sebelumnya")
        }
        optionsWithExtras.append("Ulang dari Awal")

        chatMessages.append(ChatMessage(text: question.text, isUser: false, isOption: false, options: []))
        chatMessages.append(ChatMessage(text: "", isUser: false, isOption: true, options: optionsWithExtras))
    }

    func handleAnswer(_ answer: String, at index: Int) {
        chatMessages[index].isAnswered = true
        chatMessages.remove(at: index)

        if answer == "Ganti Pilihan Sebelumnya" {
            guard !previousAnswers.isEmpty else { return }
            if chatMessages.count >= 2 {
                chatMessages.removeLast(2)
            }
            chatMessages.append(ChatMessage(text: "Kamu memilih untuk edit jawaban sebelumnya.", isUser: true, isOption: false, options: []))
            let last = previousAnswers.removeLast()
            currentQuestionIndex = last.questionIndex

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showNextQuestion()
            }
            return
        }

        if answer == "Ulang dari Awal" {
            chatMessages.append(ChatMessage(text: "Memulai ulang dari awal... 🔄", isUser: true, isOption: false, options: []))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.startChat()
            }
            return
        }

        if answer == "Kurang Pas Nih" {
            showRecommendations = false
            chatMessages.append(ChatMessage(text: "Memulai ulang dari awal... 🔄", isUser: true, isOption: false, options: []))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.startChat()
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
        showRecommendations = false
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

    private func filterStalls(location: String?, budget: String?, cuisine: String?) {
        recommendedStalls = allStalls.filter { stall in
            let matchLocation = location == "Bebas Di Mana Aja" || stall.gop.contains(location ?? "")
            let matchBudget = budget == "Budgetnya Bebas" || stall.budget.contains(budget ?? "")
            let matchCuisine = cuisine == "Apa Aja" || stall.cuisine.contains(cuisine ?? "")
            return matchLocation && matchBudget && matchCuisine
        }
    }
}
