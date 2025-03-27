//
//  ContentView.swift
//  foodies
//
//  Created by Bryan Bramaskara on 20/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var chatMessages: [(text: String, isUser: Bool, isOption: Bool)] = []
    @State private var currentQuestionIndex: Int = -1
    @State private var hasStarted: Bool = false
    @State private var answeredQuestions: Set<Int> = []

    let questions: [(text: String, options: [String])] = [
        ("Sekarang kamu ada di GOP berapa?", ["GOP 1", "GOP 6", "GOP 9"]),
        ("Berapa budget makan kamu?", ["<20.000", "20.000-30.000", ">30.000"]),
        ("Apakah ada cuisine favorit kamu?", ["Indonesian", "Japanese", "Chinese"]),
        ("berikut adalah rekomendasi dari kami, apakah kamu menyukainya?", ["yes","no"]),
        ("Apakah kamu menyukai aplikasi ini?", ["Yes", "No"])
    ]
    
    var body: some View {
        StallsCard(stall: Stall(name: "asd", image: "", rating: 0.0, location: "asdsa", category: [], lowestPrice: 5, highestPrice: 10, paymentMethod: [], details: ""))
        /*Stack {
            // nambahin background (gambar background masih contoh aja, masih coba2 pake background)
            Image("backgroundawal")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if !hasStarted {
                    VStack {
                        Text("Halo! Bingung mau makan apa? Yuk cobain rekomendasi dari kami!")
                            .font(.system(size: 20)) // mengubah ukuran font
                            .font(.title) // jenis font
                            .padding()
                            
                        
                        Button(action: {
                            hasStarted = true
                            startChat()
                        }) {
                            Image("startbutton") // nambahin gambar button
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 50)
                                    .opacity(hasStarted ? 0.5 : 1.0) // Efek transparan setelah diklik?
                        }
                    }
                    .padding()
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 15) {
                                ForEach(chatMessages.indices, id: \.self) { index in
                                    let message = chatMessages[index]
                                    
                                    if message.isOption, let questionIndex = questions.firstIndex(where: { $0.options.joined(separator: ",") == message.text }) {
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
                                        ChatBubble(text: message.text, isUser: message.isUser)
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
        } */
    }
       
    
    private func startChat() {
        currentQuestionIndex = 0
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        if currentQuestionIndex < questions.count {
            let nextQuestion = questions[currentQuestionIndex]
            chatMessages.append((nextQuestion.text, false, false))
            chatMessages.append((nextQuestion.options.joined(separator: ","), false, true))
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
            }
        }
    }
}

struct ChatBubble: View {
    let text: String
    let isUser: Bool
    
    var body: some View {
        HStack {
            if isUser {
                Spacer()
                Text(text)
                    .font(.title)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(14)
            } else {
                Text(text)
                    .font(.title)
                    .padding()
                    .background(Color.white.opacity(0.7)) // Supaya teks kebaca dari background
                    .cornerRadius(8)
                Spacer()
            }
        }
    }
}
  

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
