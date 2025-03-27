////
////  CuisinePage.swift
////  foodies
////
////  Created by Eliza Vornia on 26/03/25.
////
//import SwiftUI
//
//struct CuisinePage: View {
//    @State private var selectedCuisine: CuisineType = .padang  // ✅ Default ke Padang
//
//    var filteredMenus: [Cuisines] {
//        Cuisines.allMenus.filter { $0.cuisine == selectedCuisine }
//    }
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("Pilih Jenis Masakan")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .padding(.top)
//
//                // ✅ Pisahkan ForEach ke dalam fungsi terpisah
//                cuisineCategoryButtons()
//
//                // ✅ Gunakan List dengan id agar lebih optimal
//                List(filteredMenus, id: \.id) { menu in
//                    NavigationLink(destination: CuisineCard(menu: menu)) {
//                        menuRow(menu: menu)
//                    }
//                }
//
//                Spacer()
//            }
//            .navigationTitle("Cuisines")
//        }
//    }
//
//    // ✅ Fungsi untuk menampilkan kategori masakan (agar kode lebih bersih)
//    @ViewBuilder
//    private func cuisineCategoryButtons() -> some View {
//        HStack {
//            ForEach(CuisineType.allCases, id: \.self) { cuisine in
//                cuisineButton(for: cuisine)
//            }
//        }
//        .padding()
//    }
//
//    // ✅ Fungsi untuk membuat button kategori
//    @ViewBuilder
//    private func /*cuisine*/Button(for cuisine: CuisineType) -> some View {
//        VStack {
//            Button(action: {
//                selectedCuisine = cuisine
//            }) {
//                Image(cuisine.rawValue.lowercased())
//                    .resizable()
//                    .frame(width: 70, height: 70)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
//                    .shadow(radius: 3)
//            }
//            Text(cuisine.rawValue.capitalized)
//                .font(.footnote)
//        }
//    }
//
//    // ✅ Fungsi untuk membuat tampilan setiap menu di dalam List
//    @ViewBuilder
//    private func menuRow(menu: Cuisines) -> some View {
//        HStack {
//            Image(menu.image)
//                .resizable()
//                .frame(width: 50, height: 50)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//            
//            VStack(alignment: .leading) {
//                Text(menu.name)
//                    .font(.headline)
//                Text("Rp \(menu.priceRange)") // ✅ Gunakan priceRange karena berupa String
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//            }
//        }
//    }
//}
//
//#Preview {
//    CuisinePage()
//}
