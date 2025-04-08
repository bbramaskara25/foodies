import SwiftUI
import Foundation

struct StartPage: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                backgroundImage

                VStack {
                    if !viewModel.hasStarted {
                        introView
                    } else {
                        chatView
                    }
                }
                .padding(.top, 10)
            }
        }
    }

    private var backgroundImage: some View {
        Image(viewModel.hasStarted ? "backgroundChat" : "backgroundSTART")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .opacity(viewModel.hasStarted ? 0.4 : 1.0)
    }

    private var introView: some View {
        VStack {
            Text("Halo! Bingung mau makan apa? Yuk cobain rekomendasi dari kami!")
                .font(.system(size: 20))
                .padding()

            Button(action: viewModel.startChat) {
                Image("FirstStart")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 50)
                    .opacity(viewModel.hasStarted ? 0.2 : 1.0)
            }
        }
        .padding()
    }

    private var chatView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(Array(viewModel.chatMessages.indices), id: \.self) { index in
                        messageView(index)
                    }

                    if !viewModel.recommendedStalls.isEmpty {
                        recommendationSection
                    }
                }
                .padding()
                .onChange(of: viewModel.chatMessages.count) { _ in
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

    private func messageView(_ index: Int) -> some View {
        let message = viewModel.chatMessages[index]

        return Group {
            if message.isOption && !message.isAnswered {
                OptionButtonsView(options: message.options) { choice in
                    viewModel.handleAnswer(choice, at: index)
                }
            } else if !message.isOption {
                if !message.text.isEmpty {
                    ChatBubble(
                        text: message.text,
                        isUser: message.isUser,
                        onUndo: {
                            viewModel.undoAnswer(for: index)
                        }
                    )
                } else {
                    EmptyView()
                }
            } else {
                EmptyView()
            }
        }
    }

    private var recommendationSection: some View {
        let recommended: [Stall] = Array(viewModel.recommendedStalls.prefix(3))

        return VStack(alignment: .leading, spacing: 12) {
            Text("Rekomendasi Stall untukmu")
                .font(.headline)
                .padding(.top, 10)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                ForEach(recommended) { stall in
                    NavigationLink(destination: StallsPage()) {
                        VStack(spacing: 8) {
                            Image(stall.name.replacingOccurrences(of: " ", with: "").lowercased())
                                .resizable()
                                .scaledToFill()
                                .frame(height: 80)
                                .clipped()
                                .cornerRadius(8)

                            Text(stall.name)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow.opacity(0.8))
                        .cornerRadius(12)
                    }
                }
            }

            HStack {
                Spacer()
                NavigationLink(destination: StallsPage()) {
                    Text("Lihat Semua")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.top, 8)
                }
                Spacer()
            }
        }
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}
