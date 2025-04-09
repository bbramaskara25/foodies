import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel

    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.chatMessages.indices, id: \.self) { index in
                            let message = viewModel.chatMessages[index]

                            if !message.text.isEmpty {
                                ChatBubble(
                                    text: message.text,
                                    isUser: message.isUser,
                                    onUndo: {
                                        viewModel.undoAnswer(for: index)
                                    }
                                )
                            }

                            if message.isOption && !message.isAnswered {
                                OptionButtonsView(options: message.options) { choice in
                                    viewModel.handleAnswer(choice, at: index)
                                }
                            }
                        }
                    }
                    .padding()
                    .onChange(of: viewModel.chatMessages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(viewModel.chatMessages.count - 1, anchor: .bottom)
                        }
                    }
                }

                Spacer()
            }
        }
        .navigationTitle("🍽️ Recommendation Bot")
        .navigationBarTitleDisplayMode(.inline)
    }
}
