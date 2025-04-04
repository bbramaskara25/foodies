import SwiftUI

struct ChatView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(message: "Welcome to the chat!", isUser: false),
        ChatMessage(message: "How can I assist you today?", isUser: false)
    ]
    
    @State private var responseOptions: [String] = [
        "What are today's specials?",
        "Any vegetarian options?",
        "What's your cheapest meal?"
    ]
    
    @Namespace var bottomID

    var body: some View {
        VStack {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(messages) { message in
                            if message.isUser {
                                UserResponse( message.message)
                            } else {
                                BotResponse( message.message)
                            }
                        }

                        Color.clear
                            .frame(height: 1)
                            .id(bottomID)
                    }
                    .padding()
                }
                .onChange(of: messages.count) { _ in
                    withAnimation {
                        scrollProxy.scrollTo(bottomID, anchor: .bottom)
                    }
                }
            }

            responseOptionsView()
                .padding(.bottom)
        }
    }

    private func responseOptionsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(responseOptions, id: \.self) { option in
                    Button(action: {
                        handleUserSelection(option)
                    }) {
                        Text(option)
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(15)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func handleUserSelection(_ response: String) {
        let userMessage = ChatMessage(message: response, isUser: true)
        messages.append(userMessage)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let botMessage: String
            switch response {
            case "What are today's specials?":
                botMessage = "Today's specials include spicy ramen and chicken rice."
                responseOptions = ["More details on ramen", "Back to menu"]
            case "Any vegetarian options?":
                botMessage = "Yes! We have veggie burgers, salads, and tofu stir-fry."
                responseOptions = ["Tofu stir-fry sounds good", "Back to menu"]
            case "What's your cheapest meal?":
                botMessage = "Our budget meal is the egg fried rice for just $3."
                responseOptions = ["Order egg fried rice", "Back to menu"]
            case "More details on ramen":
                botMessage = "The ramen is pork-based with miso broth and soft-boiled egg."
                responseOptions = ["Order ramen", "Back to menu"]
            case "Back to menu":
                botMessage = "Sure! Here's the main menu again."
                responseOptions = [
                    "What are today's specials?",
                    "Any vegetarian options?",
                    "What's your cheapest meal?"
                ]
            default:
                botMessage = "Thanks for your input!"
                responseOptions = ["Back to menu"]
            }

            messages.append(ChatMessage(message: botMessage, isUser: false))
        }
    }
}

#Preview {
    NavigationView {
        ChatView()
    }
}
