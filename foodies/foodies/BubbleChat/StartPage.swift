//
//  ContentView.swift
//  foodies
//
//  Created by Bryan Bramaskara on 20/03/25.
//
import SwiftUI

struct StartPage: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        ZStack {
            Image(viewModel.hasStarted ? "backgroundChat" : "backgroundSTART")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if !viewModel.hasStarted {
                    VStack {
                        Text("Halo! Bingung mau makan apa? Yuk cobain rekomendasi dari kami!")
                            .font(.system(size: 20))
                            .padding()
                        
                        Button(action: viewModel.startChat) {
                            Image("FirstStart")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 50)
                                .opacity(viewModel.hasStarted ? 0.5 : 1.0)
                        }
                    }
                    .padding()
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 15) {
                                ForEach(viewModel.chatMessages.indices, id: \ .self) { index in
                                    let message = viewModel.chatMessages[index]
                                    
                                    if message.isOption && !message.isAnswered {
                                        OptionButtonsView(options: message.options) { choice in
                                            viewModel.handleAnswer(choice, at: index)
                                        }
                                    } else if !message.isOption {
                                        ChatBubble(text: message.text, isUser: message.isUser, onUndo: {
                                            viewModel.undoAnswer(for: index)
                                        })
                                    }
                                }
                            }
                            .padding()
                            .onChange(of: viewModel.chatMessages.count) {
                                withAnimation {
                                    proxy.scrollTo(viewModel.chatMessages.count - 1, anchor: .bottom)
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
}

struct CStartPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
