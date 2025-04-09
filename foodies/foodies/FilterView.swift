//
//  FilterView.swift
//  foodies
//
//  Created by Eliza Vornia on 06/04/25.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedFilters: [String: Set<String>]  // Gunakan Set untuk multiple selections
    var applyFilters: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack{
            VStack {
                Text("Filters")
                    .font(.largeTitle)
                    .padding(.top, -30)

                Group {
                    FilterButton(
                        segmentTitle: "Lokasi",
                        itemTitle: ["GOP 1", "GOP 6", "GOP 9"],
                        selectedFilters: $selectedFilters
                    )
                    FilterButton(
                        segmentTitle: "Range Harga",
                        itemTitle: ["<Rp 10k", "Rp 10-20k", ">Rp 20k"],
                        selectedFilters: $selectedFilters
                    )
                    FilterButton(
                        segmentTitle: "Kategori",
                        itemTitle: ["Nasi", "Mie", "Cemilan", "Sayuran", "Berkuah", "Minuman"],
                        selectedFilters: $selectedFilters
                    )
                    FilterButton(
                        segmentTitle: "Rating",
                        itemTitle: [">1", ">2", ">3", ">4", "5"],
                        selectedFilters: $selectedFilters
                    )
                    FilterButton(
                        segmentTitle: "Pernah Dipesan",
                        itemTitle: ["Yes", "No"],
                        selectedFilters: $selectedFilters,
                        isSingleSelection: true
                    )
                }
                .padding(.top, 12)
                .padding(.horizontal)

                Spacer()

                VStack {
                    Text("Total: \(selectedFilters.reduce(0) { $0 + $1.value.count }) filters applied")
                        .font(.headline)

                    Button(action: {
                        applyFilters()
                        dismiss()
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                    .foregroundColor(.orange)
                }
            }

        }
        }
}

struct FilterButton: View {
    var segmentTitle: String
    var itemTitle: [String]
    @Binding var selectedFilters: [String: Set<String>]
    var isSingleSelection: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(segmentTitle)
                .font(.headline)
                .padding(.top, 5)

            // ScrollView untuk horizontal scroll jika item terlalu banyak
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(itemTitle, id: \.self) { option in
                        Button(action: {
                            toggleSelection(for: option)
                        }) {
                            Text(option)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(isSelected(option) ? Color.orange : Color.gray.opacity(0.2))
                                .foregroundColor(isSelected(option) ? .white : .black)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    private func isSelected(_ option: String) -> Bool {
        selectedFilters[segmentTitle]?.contains(option) ?? false
    }

    private func toggleSelection(for option: String) {
            if isSingleSelection {
                if selectedFilters[segmentTitle]?.contains(option) == true {
                    selectedFilters.removeValue(forKey: segmentTitle)
                } else {
                    selectedFilters[segmentTitle] = [option]
                }
            } else {
                if selectedFilters[segmentTitle]?.contains(option) == true {
                    selectedFilters[segmentTitle]?.remove(option)
                    if selectedFilters[segmentTitle]?.isEmpty == true {
                        selectedFilters.removeValue(forKey: segmentTitle)
                    }
                } else {
                    selectedFilters[segmentTitle, default: []].insert(option)
                }
            }
        }
}

#Preview {
    FilterView(selectedFilters: .constant([:]), applyFilters: {})
}
