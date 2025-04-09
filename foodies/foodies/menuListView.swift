//
//  MenuListView.swift
//  foodies
//
//  Created by Eliza Vornia on 08/04/25.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value: Int
    var range: ClosedRange<Int> = 0...30

    @State private var textValue: String = ""

    var body: some View {
        HStack(spacing: 8) {
            Button(action: {
                if value > range.lowerBound {
                    value -= 1
                    textValue = String(value)
                }
            }) {
                Image(systemName: "minus.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }

            TextField("", text: $textValue)
                .keyboardType(.numberPad)
                .frame(width: 30, height: 30)
                
                .background(Color(.systemGray6))
                .cornerRadius(6)
                .font(.headline)
                .multilineTextAlignment(.center)
                .onChange(of: textValue) { newValue in
                    // Validasi input: hanya angka
                    if let intValue = Int(newValue), range.contains(intValue) {
                        value = intValue
                    } else if newValue.isEmpty {
                        // Kosongkan tidak langsung ubah nilai
                    } else {
                        // Kembalikan ke nilai sebelumnya jika input tidak valid
                        textValue = String(value)
                    }
                }

            Button(action: {
                if value < range.upperBound {
                    value += 1
                    textValue = String(value)
                }
            }) {
                Image(systemName: "plus.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
        }
        .onAppear {
            textValue = String(value)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var quantity = 3
        var body: some View {
            CustomStepper(value: $quantity)
                .padding()
        }
    }

    return PreviewWrapper()
}
