//
//  SpeechBubbleShape.swift
//  foodies
//
//  Created by Eliza Vornia on 04/04/25.
//
import SwiftUI

struct SpeechBubbleShape: Shape {
    var isUser: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius: CGFloat = 16
        let tailSize: CGFloat = 10
        
        if isUser {
            path.addRoundedRect(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width - tailSize, height: rect.height), cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
            path.move(to: CGPoint(x: rect.maxX - tailSize, y: rect.maxY - 20))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 15))
            path.addLine(to: CGPoint(x: rect.maxX - tailSize, y: rect.maxY - 10))
        } else {
            path.addRoundedRect(in: CGRect(x: rect.minX + tailSize, y: rect.minY, width: rect.width - tailSize, height: rect.height), cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
            path.move(to: CGPoint(x: rect.minX + tailSize, y: rect.maxY - 20))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 15))
            path.addLine(to: CGPoint(x: rect.minX + tailSize, y: rect.maxY - 10))
        }
        return path
    }
}

#Preview {
    VStack(spacing: 20) {
        // Bubble bot
        SpeechBubbleShape(isUser: false)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 200, height: 60)
            .padding()
        
        // Bubble user
        SpeechBubbleShape(isUser: true)
            .fill(Color.blue.opacity(0.7))
            .frame(width: 200, height: 60)
            .padding()
    }
    .padding()
    .background(Color.black.opacity(0.1))
}

