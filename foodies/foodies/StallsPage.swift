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
    @State private var selectedFilters: [String: String] = [:]  // Store final filters
    @State private var tempFilters: [String: String] = [:]  // Store temporary filters during modal

    var stalls: [Stall] = Stall.all

    var filteredStalls: [Stall] {
        stalls.filter { stall in
            let matchesSearch = searchText.isEmpty ||
                stall.name.lowercased().contains(searchText.lowercased()) ||
                stall.location.lowercased().contains(searchText.lowercased())
            
            let matchesLocation = selectedFilters["Location"].map { stall.location == $0 } ?? true

            let matchesPrice = selectedFilters["Price Range"].map { priceFilter in
                switch priceFilter {
                    case "<10k": return stall.lowestPrice < 10
                    case "10-20k": return stall.lowestPrice >= 10 && stall.highestPrice <= 20
                    case ">20k": return stall.highestPrice > 20
                    default: return true
                }
            } ?? true

            let matchesCategory = selectedFilters["Category"].map { category in
                stall.category.contains(category)
            } ?? true

            let matchesRating = selectedFilters["Rating"].map { ratingFilter in
                if let ratingValue = Double(ratingFilter.replacingOccurrences(of: ">", with: "")) {
                    return stall.rating >= ratingValue
                }
                return true
            } ?? true
            
            let matchesTriedBefore = selectedFilters["Tried Before"].map { triedBefore in
                            if triedBefore == "Yes" {
                                return stall.wasOrdered
                            } else if triedBefore == "No" {
                                return !stall.wasOrdered
                            }
                            return true
                        } ?? true

            return matchesSearch && matchesLocation && matchesPrice && matchesCategory && matchesRating && matchesTriedBefore
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredStalls, id: \.id) { stall in
                NavigationLink(destination: StallDetailView(stall: stall)
                    .modelContainer(for: OrderItem.self)) { //menyediakan akses ke swiftData
                    StallsCard(stall: stall)
                }
            }
            .navigationTitle("Stalls")
            .searchable(text: $searchText, prompt: "Search stalls...")
            .toolbar {
                Button {
                    tempFilters = [:] // Reset tempFilters when opening filter
                    isShowFilter = true
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $isShowFilter) {
                FilterView(selectedFilters: $tempFilters, applyFilters: {
                    selectedFilters = tempFilters  // Apply filters only when clicking "Apply"
                })
            }
        }
        .modelContainer(for : OrderItem.self) // pastikan akses ke swiftData
    }
}

#Preview {
    StallsPage()
        .modelContainer(for: OrderItem.self) // pastikan preview juga memiliki akses ke SwiftData
}
