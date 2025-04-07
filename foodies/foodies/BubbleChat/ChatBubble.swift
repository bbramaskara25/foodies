//
//  ChatBubble.swift
//  foodies
//
//  Created by Eliza Vornia on 04/04/25.
//
import SwiftUI

struct ChatBubble: View {
    let text: String
    let isUser: Bool
    var onUndo: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            if isUser {
                Spacer()
                HStack(spacing: 8) {
                    Text(text)
                        .padding()
                        .background(SpeechBubbleShape(isUser: true).fill(Color.white))
                        .foregroundColor(.black)
                        .font(.body)
                    if let onUndo = onUndo {
                        Button(action: onUndo) {
                            Image(systemName: "square.and.pencil.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.red)
                                
                        }
                        .padding(.trailing, 5)
                    }
                }
            } else {
                HStack {
                    Text(text)
                        .padding()
                        .background(SpeechBubbleShape(isUser: false).fill(Color.white.opacity(0.8)))
                        .foregroundColor(.black)
                        .font(.body)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    VStack {
        ChatBubble(text: "Halo, El!", isUser: false)
        ChatBubble(text: "Hai haii!", isUser: true, onUndo: {})
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}
