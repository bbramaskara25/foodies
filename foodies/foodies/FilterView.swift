//
//  FilterView.swift
//  foodies
//
//  Created by Eliza Vornia on 27/03/25.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedFilters: [String: String]
    var applyFilters: () -> Void  // Callback to apply filters
    @Environment(\.dismiss) var dismiss  // To close the filter modal

    var body: some View {
        VStack {
            Text("Filters")
                .font(.largeTitle)
                .padding(.top)

            Group {
                FilterButton(segmentTitle: "Location", itemTitle: ["GOP 1", "GOP 6", "GOP 9"], selectedFilters: $selectedFilters).frame(width: 400, height: 100, alignment: .leading)
                FilterButton(segmentTitle: "Price Range", itemTitle: ["<10k", "10-20k", ">20k"], selectedFilters: $selectedFilters).frame(width: 400, height: 100, alignment: .leading)
                FilterButton(segmentTitle: "Category", itemTitle: ["Rice", "Noodles", "Snacks", "Vegetables"], selectedFilters: $selectedFilters).frame(width: 400, height: 100, alignment: .leading)
                FilterButton(segmentTitle: "Rating", itemTitle: [">1", ">2", ">3", ">4", "5"], selectedFilters: $selectedFilters).frame(width: 400, height: 100, alignment: .leading)
                FilterButton(segmentTitle: "Tried Before", itemTitle: ["Yes", "No"], selectedFilters: $selectedFilters).frame(width: 400, height: 100, alignment: .leading)
            }
            .padding(.top, 12)
            .padding(.horizontal)

            Spacer()

            VStack {
                Text("Total: \(selectedFilters.count) filters applied")
                    .font(.headline)

                Button(action: {
                    applyFilters() // Apply selected filters
                    dismiss() // Close modal
                }) {
                    Text("Apply")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .frame(width: 300, height: 50, alignment: .center)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}


struct FilterButton: View {
    var segmentTitle: String
    var itemTitle: [String]
    @Binding var selectedFilters: [String: String]

    @State private var selectedOption: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text(segmentTitle)
                .font(.headline)
                .padding(.top, 5)

            HStack {
                ForEach(itemTitle, id: \.self) { option in
                    Button(action: {
                        if selectedOption == option {
                            selectedOption = nil
                            selectedFilters[segmentTitle] = nil
                        } else {
                            selectedOption = option
                            selectedFilters[segmentTitle] = option
                        }
                    }) {
                        Text(option)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(selectedOption == option ? Color.orange : Color.gray.opacity(0.2))
                            .foregroundColor(selectedOption == option ? .white : .black)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}



#Preview {
    FilterView(selectedFilters: .constant([:]), applyFilters: {}) // Using a constant empty dictionary for preview
}
