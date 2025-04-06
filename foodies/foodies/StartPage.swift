//
//  ContentView.swift
//  foodies
//
//  Created by Bryan Bramaskara on 20/03/25.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

<<<<<<< Updated upstream:foodies/foodies/ContentView.swift
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
=======
    let questions: [(text: String, options: [String])] = [
        ("Sekarang kamu ada di GOP berapa?", ["GOP 1", "GOP 6", "GOP 9","Prefer not to mention"]),
        ("Berapa budget makan kamu?", ["<20.000", "20.000-30.000", ">30.000","Prefer not to mention"]),
        ("Apakah ada cuisine favorit kamu?", ["Indonesian", "Japanese", "Chinese","Prefer not to mention"]),
        ("Berikut adalah rekomendasi dari kami, apakah kamu menyukainya?", ["Yes","No"]),
        ("Apakah kamu menyukai aplikasi ini?", ["Yes", "No"])
    ]

    var body: some View {
        ZStack {
            Image("backgroundSTART")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if !hasStarted {
                    VStack {
                        Text("Halo! Bingung mau makan apa? Yuk cobain rekomendasi dari kami!")
                            .font(.system(size: 20))
                            .padding()
                        
                        Button(action: {
                            hasStarted = true
                            startChat()
                        }) {
                            Image("FirstStart")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 50)
                                .opacity(hasStarted ? 5.0 : 1.0)
                        }
                    }
                    .padding()
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 15) {
                                ForEach(chatMessages.indices, id: \.self) { index in
                                    let message = chatMessages[index]
                                    
                                    if message.isOption,
                                       let questionIndex = questions.firstIndex(where: { $0.options.joined(separator: ",") == message.text }) {
                                        
                                        if !answeredQuestions.contains(questionIndex) {
                                            OptionButtonsView(options: message.text.split(separator: ",").map(String.init)) { choice in
                                                chatMessages.append((choice, true, false))
                                                answeredQuestions.insert(questionIndex)
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    currentQuestionIndex += 1
                                                    showNextQuestion()
                                                }
                                            }
                                        }
                                    } else {
                                        ChatBubble(
                                            text: message.text,
                                            isUser: message.isUser,
                                            onErase: {
                                                if message.isUser,
                                                   let previousQuestionIndex = chatMessages.prefix(index).lastIndex(where: { !$0.isUser && !$0.isOption }),
                                                   let realQuestionIndex = questions.firstIndex(where: { $0.text == chatMessages[previousQuestionIndex].text }) {
                                                    undoAnswer(for: realQuestionIndex)
                                                }
                                            }
                                        )
                                    }
                                }
                            }
                            .padding()
                            .onChange(of: chatMessages.count) {
                                withAnimation {
                                    proxy.scrollTo(chatMessages.count - 1, anchor: .bottom)
                                }
                            }
                        }
                        .safeAreaInset(edge: .top) {
                            Color.clear.frame(height: 40)
                        }
                    }
                }
            }
            .padding(.top, 10)
        }
    }

    // Memulai pertanyaan pertama
    private func startChat() {
        currentQuestionIndex = 0
        showNextQuestion()
    }

    // Menampilkan pertanyaan dan opsi
    private func showNextQuestion() {
        if currentQuestionIndex < questions.count {
            let nextQuestion = questions[currentQuestionIndex]
            chatMessages.append((nextQuestion.text, false, false))
            chatMessages.append((nextQuestion.options.joined(separator: ","), false, true))
        }
    }

    // Membatalkan jawaban user dan memunculkan opsi ulang
    private func undoAnswer(for questionIndex: Int) {
        answeredQuestions.remove(questionIndex)
        
        if let questionMessageIndex = chatMessages.firstIndex(where: { $0.text == questions[questionIndex].text }) {
            chatMessages.removeSubrange(questionMessageIndex..<chatMessages.count)
            currentQuestionIndex = questionIndex
            showNextQuestion()
        }
    }
}

struct OptionButtonsView: View {
    let options: [String]
    let onSelect: (String) -> Void

    var body: some View {
        VStack {
            ForEach(options, id: \.self) { option in
                Button(action: { onSelect(option) }) {
                    Text(option)
                        .font(.title)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .frame(maxWidth: 250, alignment: .leading)
                }
>>>>>>> Stashed changes:foodies/foodies/StartPage.swift
            }
        }
    }
}
struct SpeechBubbleShape: Shape {
    var isUser: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let cornerRadius: CGFloat = 16
        let tailSize: CGFloat = 10

        if isUser {
            // User bubble (kanan, tail kanan bawah)
            path.addRoundedRect(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width - tailSize, height: rect.height), cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
            path.move(to: CGPoint(x: rect.maxX - tailSize, y: rect.maxY - 20))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 15))
            path.addLine(to: CGPoint(x: rect.maxX - tailSize, y: rect.maxY - 10))
        } else {
            // Bot bubble (kiri, tail kiri bawah)
            path.addRoundedRect(in: CGRect(x: rect.minX + tailSize, y: rect.minY, width: rect.width - tailSize, height: rect.height), cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
            path.move(to: CGPoint(x: rect.minX + tailSize, y: rect.maxY - 20))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 15))
            path.addLine(to: CGPoint(x: rect.minX + tailSize, y: rect.maxY - 10))
        }

        return path
    }
}

<<<<<<< Updated upstream:foodies/foodies/ContentView.swift
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
=======
struct ChatBubble: View {
    let text: String
    let isUser: Bool
    var onErase: (() -> Void)? = nil

    var body: some View {
        HStack {
            if isUser {
                Spacer()
                HStack(spacing: 8) {
                    Text(text)
                        .padding()
                        .background(
                            SpeechBubbleShape(isUser: true)
                                .fill(Color.white)
                        )
                        .foregroundColor(.black)
                        .font(.title2)

                    if let onErase = onErase {
                        Button(action: onErase) {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.red)
                        }
                        .padding(.trailing, 5)
                    }
                }
            } else {
                HStack {
                    Text(text)
                        .padding()
                        .background(
                            SpeechBubbleShape(isUser: false)
                                .fill(Color.white.opacity(0.8))
                        )
                        .foregroundColor(.black)
                        .font(.title2)
                    Spacer()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
>>>>>>> Stashed changes:foodies/foodies/StartPage.swift
}
