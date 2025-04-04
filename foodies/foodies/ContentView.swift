import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Time]

    @AppStorage("userName") private var userName: String = ""
    @State var showChatView: Bool
    @State var messages: [ChatMessage]

    init(showChatView: Bool = false, messages: [ChatMessage] = []) {
        self._showChatView = State(initialValue: showChatView)
        self._messages = State(initialValue: messages)
    }

    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                headerView
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "13A435"))

                if showChatView {
                    ChatView()
                } else {
                    VStack(spacing: 40) {
                        VStack(alignment: .center, spacing: 20) {
                            Text("Hey there!\nNot sure what to eat?\nTry our budget-friendly picks!")
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color(hex: "DCF8C6"))
                                .foregroundColor(.black)
                                .cornerRadius(16)
                                .shadow(radius: 2)

                            Button(action: {
                                messages = [
                                    ChatMessage(message: "Welcome to the chat!", isUser: false),
                                    ChatMessage(message: "How can I assist you today?", isUser: false)
                                ]
                                showChatView = true
                            }) {
                                Text("Start Here")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: "13A435"))
                                    .cornerRadius(20)
                            }
                            .padding(.horizontal, 30)
                        }
                        .padding()

                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        } detail: {}
        .onAppear {
            promptForUserName()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Header View
    private var headerView: some View {
        HStack {
            Image("foodies")
                .resizable()
                .frame(width: 80, height: 25)
                .padding(.leading)

            Text("\(greetingMessage), \(userName)!")
                .font(.headline)
                .padding(.horizontal)
                .foregroundColor(.white)

            Spacer()
        }
        .padding(.vertical)
        .background(Color(hex: "13A435"))
    }

    private var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12: return "Good Morning"
        case 12..<17: return "Good Afternoon"
        case 17..<21: return "Good Evening"
        default: return "Good Night"
        }
    }

    private func promptForUserName() {
        if userName.isEmpty {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Welcome!", message: "Please enter your name:", preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.placeholder = "Your Name"
                }
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    if let inputText = alert.textFields?.first?.text, !inputText.isEmpty {
                        userName = inputText
                    }
                })
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.present(alert, animated: true)
                }
            }
        }
    }

    private func sendMessage(_ text: String) {
        messages.append(ChatMessage(message: text, isUser: true))

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let botResponse = ChatMessage(message: "You chose: \(text). How can I further assist you?", isUser: false)
            messages.append(botResponse)
        }
    }
}

// MARK: - Hex Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

// MARK: - Preview with ChatView Hidden Initially
#Preview {
    ContentViewPreviewWrapper()
        .modelContainer(for: Time.self, inMemory: true)
}

private struct ContentViewPreviewWrapper: View {
    var body: some View {
        ContentView()
    }
}
