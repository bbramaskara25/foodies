//
//  OptionButtonsView.swift
//  foodies
//
//  Created by Eliza Vornia on 04/04/25.
//

import SwiftUI

struct OptionButtonsView: View {
    let options: [String]
    let onSelect: (String) -> Void
    
    var body: some View {
        VStack {
            ForEach(options, id: \ .self) { option in
                Button(action: { onSelect(option) }) {
                    Text(option)
                        .font(.subheadline)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .frame(maxWidth: 100, alignment: .leading)
                }
            }
        }
    }
}
#Preview {
    OptionButtonsView(options: ["Option 1", "Option 2", "Option 3"]) { selectedOption in
        print("Selected: \(selectedOption)")
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
