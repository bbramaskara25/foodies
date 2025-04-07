//
//  stallsPage.swift
//  foodies
//
//  Created by Eliza Vornia on 25/03/25.
//
import SwiftUI
import SwiftData

struct StallsPage: View {
    @State private var searchText: String = ""
    @State private var isShowFilter: Bool = false
    @State var selectedFilters: [String: Set<String>] = [:] // ✅ Final filters
    @State private var tempFilters: [String: Set<String>] = [:] // ✅ Temp filters for modal

    var stalls: [Stall] = Stall.all

    var filteredStalls: [Stall] {
        stalls.filter { stall in
            let matchesSearch = searchText.isEmpty ||
                stall.name.lowercased().contains(searchText.lowercased()) ||
                stall.location.lowercased().contains(searchText.lowercased())

            let matchesLocation = selectedFilters["Location"].map { filters in
                filters.contains(stall.location)
            } ?? true

            let matchesPrice = selectedFilters["Price Range"].map { filters in
                filters.contains(where: { filter in
                    switch filter {
                        case "<10k": return stall.lowestPrice < 10
                        case "10-20k": return stall.lowestPrice >= 10 && stall.highestPrice <= 20
                        case ">20k": return stall.highestPrice > 20
                        default: return false
                    }
                })
            } ?? true

            let matchesCategory = selectedFilters["Category"].map { filters in
                filters.contains(where: { stall.category.contains($0) })
            } ?? true

            let matchesRating = selectedFilters["Rating"].map { filters in
                filters.contains(where: { filter in
                    if let ratingValue = Double(filter.replacingOccurrences(of: ">", with: "")) {
                        return stall.rating >= ratingValue
                    }
                    return false
                })
            } ?? true

            let matchesTriedBefore = selectedFilters["Tried Before"].map { filters in
                filters.contains(where: { filter in
                    if filter == "Yes" {
                        return stall.wasOrdered
                    } else if filter == "No" {
                        return !stall.wasOrdered
                    }
                    return false
                })
            } ?? true

            return matchesSearch && matchesLocation && matchesPrice && matchesCategory && matchesRating && matchesTriedBefore
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredStalls, id: \.id) { stall in
                NavigationLink(destination: StallDetailView(stall: stall)
                    .modelContainer(for: OrderItem.self)) {
                    StallsCard(stall: stall)
                }
            }
            .navigationTitle("Stalls")
            .searchable(text: $searchText, prompt: "Search stalls...")
            .toolbar {
                Button {
                    tempFilters = selectedFilters // Pre-fill temp filters with current
                    isShowFilter = true
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $isShowFilter) {
                FilterView(selectedFilters: $tempFilters) {
                    selectedFilters = tempFilters  // Apply filters on confirm
                }
            }
        }
        .modelContainer(for: OrderItem.self)
    }
}

#Preview {
    StallsPage()
        .modelContainer(for: OrderItem.self)
}
