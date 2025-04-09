import SwiftUI
import Foundation

struct StartPage: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundImage

                VStack(spacing: 0) {
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
        VStack(spacing: 1) { // Prevent space between header and messages
            Spacer()
            Spacer()
            Spacer()
            headerView
            
            ScrollViewReader { proxy in
                ScrollView {
                    Spacer()
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(Array(viewModel.chatMessages.indices), id: \.self) { index in
                            messageView(index)
                        }

                        if viewModel.showRecommendations && !viewModel.recommendedStalls.isEmpty {
                            recommendationSection
                        }

                        if viewModel.showStallNavigationButton {
                            HStack {
                                Spacer()
                                NavigationLink(destination: StallsPage()) {
                                    Text("Lihat Semua Stall")
                                        .font(.headline)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.orange)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    .onChange(of: viewModel.chatMessages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(viewModel.chatMessages.count - 1, anchor: .bottom)
                        }
                    }
                }
            }
        }
    }

    @Environment(\.dismiss) private var dismiss

    private var headerView: some View {
        HStack {

            ZStack {
                Image("Recommender")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 80)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, -15) // smaller vertical padding
        .background(Color.white.opacity(1.0))
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
        let recommended = Array(viewModel.recommendedStalls.prefix(3))

        return VStack(alignment: .leading, spacing: 12) {
            Text("Rekomendasi Stall untukmu")
                .font(.headline)
                .padding(.top, 10)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                ForEach(recommended) { stall in
                    if let fullStall = Stall.all.first(where: { $0.name == stall.name }) {
                        NavigationLink(destination: MenuPage(stall: fullStall)) {
                            VStack(spacing: 8) {
                                Image(fullStall.images.first ?? "placeholder")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 80)
                                    .clipped()
                                    .cornerRadius(8)

                                Text(fullStall.name)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(12)
                        }
                    }
                }
            }

            HStack {
                Spacer()
                NavigationLink(destination: StallsPage()) {
                    HStack {
                        Spacer()
                        NavigationLink(destination: StallsPage()) {
                            Text("Lihat Semua Stall")
                                .font(.body.bold())
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        Spacer()
                    }
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
