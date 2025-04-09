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
    @State var selectedFilters: [String: Set<String>] = [:]
    @State private var tempFilters: [String: Set<String>] = [:]

    var stalls: [Stall] = Stall.all

    var filteredStalls: [Stall] {
        stalls.filter { stall in
            let matchesSearch = searchText.isEmpty ||
                stall.name.lowercased().contains(searchText.lowercased()) ||
                stall.location.lowercased().contains(searchText.lowercased())

            let matchesLocation = selectedFilters["Location"].map { $0.contains(stall.location) } ?? true

            let matchesPrice = selectedFilters["Price Range"].map { filters in
                filters.contains(where: { filter in
                    switch filter {
//<<<<<<< HEAD
                    case "<10k": return stall.lowestPrice < 10000
                    case "10-20k": return stall.lowestPrice >= 10000 && stall.highestPrice <= 20000
                    case ">20k": return stall.highestPrice > 20000
//=======
                    case "<Rp 10k": return stall.lowestPrice < 10
                    case "Rp 10-20k": return stall.lowestPrice >= 10 && stall.highestPrice <= 20
                    case ">Rp 20k": return stall.highestPrice > 20
//>>>>>>> main
                    default: return false
                    }
                })
            } ?? true

            let matchesCategory = selectedFilters["Category"].map {
                $0.contains(where: { stall.category.contains($0) })
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
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Image("Stalls")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 10)

                        Spacer()
                        Button {
                            tempFilters = selectedFilters
                            isShowFilter = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()

                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.orange)
                        TextField("Search stalls...", text: $searchText)
                            .placeholder(when: searchText.isEmpty) {
                                Text("Search stalls...")
                                    .foregroundColor(.orange)
                            }
                            .foregroundColor(.primary)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(10)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    // List of stalls
                    List(filteredStalls, id: \.id) { stall in
                        NavigationLink(destination: MenuPage(stall: stall)) {
                            StallsCard(stall: stall)
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 0)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
            .sheet(isPresented: $isShowFilter) {
                FilterView(selectedFilters: $tempFilters) {
                    selectedFilters = tempFilters
                }
            }
        }
    }
}

#Preview {
    StallsPage()
        .modelContainer(for: OrderItem.self)
}
