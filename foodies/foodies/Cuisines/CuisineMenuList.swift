//
//  CuisineMenuList.swift
//  foodies
//
//  Created by Eliza Vornia on 26/03/25.
//

import SwiftUI

struct CuisineMenuList: View {
    var selectedCuisine: CuisineType
    
    var filteredMenus: [Cuisines] {
        Cuisines.allMenus.filter { $0.cuisine == selectedCuisine }
    }
    
    var body: some View {
        List(filteredMenus, id: \.id) { menu in
            HStack {
                Image(menu.image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(menu.name)
                        .font(.headline)
                    Text("Rp \(menu.priceRange)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(selectedCuisine.rawValue.capitalized)
    }
}

#Preview {
    CuisineMenuList(selectedCuisine: .padang)
}
