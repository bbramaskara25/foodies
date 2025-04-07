import SwiftUI

struct OptionButtonsView: View {
    let options: [String]
    var onSelect: (String) -> Void

    @State private var maxTextWidth: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Hidden text to measure max width
            Text(longestOption)
                .font(.system(size: 15, weight: .heavy))
                .background(GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            maxTextWidth = geometry.size.width
                        }
                })
                .hidden() // Don’t show the measuring text

            ForEach(options, id: \.self) { option in
                Button(action: {
                    onSelect(option)
                }) {
                    Text(option)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                        .frame(width: maxTextWidth + 28, alignment: .leading) // +28 for padding
                        .background(Color.orange)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
                        .font(.system(size: 15, weight: .heavy))
                }
            }
        }
    }

    private var longestOption: String {
        options.max(by: { $1.count > $0.count }) ?? ""
    }
}

#Preview {
    OptionButtonsView(options: ["Option 1", "Option 2", "Option 3"]) { _ in }
}
