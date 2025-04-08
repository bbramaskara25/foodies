import SwiftUI

struct ChatBubble: View {
    let text: String
    let isUser: Bool
    let onUndo: () -> Void

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if isUser {
                Spacer()
                HStack(spacing: 8) {
                    Text(text)
                        .padding()
                        .background(SpeechBubbleShape(isUser: true).fill(Color.white))
                        .foregroundColor(.black)
                        .font(.body)
                }
                .padding(.trailing)
            } else {
                HStack(alignment: .bottom, spacing: 1) {
                    Image("maskotTelur")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.leading, 4) // Pushes avatar to left edge more tightly
                    
                    Text(text)
                        .padding()
                        .background(SpeechBubbleShape(isUser: false).fill(Color.yellow.opacity(0.8)))
                        .foregroundColor(.black)
                        .font(.body)
                    
                    Spacer()
                }
                .padding(.leading, 4) // Keeps overall left side tight
            }
        }
        .padding(.vertical, 4)
    }
}
#Preview {
    VStack {
        ChatBubble(text: "Hello", isUser: false, onUndo: {})
        ChatBubble(text: "Hello, world!", isUser: true, onUndo: {})
    }
}
