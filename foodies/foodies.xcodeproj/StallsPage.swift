//
//  stallsPage.swift
//  foodies
//
//  Created by Eliza Vornia on 25/03/25.
//
import Foundation
import SwiftUI

struct StallsPage: View {
    @State private var searchText: String = ""
    @State private var isShowFilter: Bool = false
//    @State private var isDetailPageShown: Bool = false
    @State private var selectedStall: Stall? = nil

    var stalls: [Stall] = Stall.all

    var filteredStalls: [Stall] {
        if searchText.isEmpty {
            return stalls
        } else {
            return stalls.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.location.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredStalls, id: \.id) { stall in
                NavigationLink(destination: StallDetailView(stall: stall)) {
                    StallsCard(stall: stall)
                }
            }
//            List(filteredStalls, id: \.id) { stall in
//                Button {
//                    selectedStall = stall
//                } label: {
//                    StallsCard(stall: stall)
//                }
//            }
            .navigationTitle("Stalls")
            .searchable(text: $searchText, prompt: "Search stalls...")
            .toolbar {
                Button {
                    isShowFilter = true
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $isShowFilter) {
                FilterView()
            }
//            .sheet(item: $selectedStall) { stall in
//                StallDetailView(stall: stall)
//            }
        }
    }
}



struct FilterView: View {
    var body: some View {
        VStack {
            Text("Filter Options")
                .font(.title)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    StallsPage()
}
