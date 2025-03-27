//
//  MenuPage.swift
//  foodies
//
//  Created by Eliza Vornia on 27/03/25.
//

import SwiftUI
import SwiftData

@Model
class OrderItem {
    var id = UUID()
    var menuName: String
    var price: Int
    var quantity: Int
    
    init(menuName: String, price: Int, quantity: Int = 0) {
        self.menuName = menuName
        self.price = price
        self.quantity = quantity
    }
}

struct MenuPage: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var orderItems: [OrderItem]
    
    @State private var notes: String = ""
    
    var menuList: [(name: String, price: Int)] = [
        ("Ayam Bakar", 10000),
        ("Ayam Bumbu", 10000),
        ("Sayur Asem", 5000),
        ("Nasi Putih", 3000),
        ("Telur Dadar", 5000),
        ("Nasi Uduk", 5000),
        ("Nasi Uduk", 5000),
        ("Nasi Uduk", 5000),
        ("Nasi Uduk", 5000),
        ("Nasi Uduk", 5000),
        ("Nasi Uduk", 5000)
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(menuList, id: \..name) { menu in
                        HStack {
                            Text(menu.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Rp \(menu.price),-")
                                .frame(width: 80, alignment: .trailing)
                            Picker("Quantity", selection: bindingForMenu(menu.name, price: menu.price)) {
                                ForEach(0..<10, id: \..self) { num in
                                    Text("\(num)")
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            
            VStack(alignment: .leading) {
                Text("Notes:")
                    .font(.headline)
                TextField("Enter your notes here", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                
                Text("Order Summary")
                    .font(.headline)
                
                ForEach(orderItems.filter { $0.quantity > 0 }) { order in
                    HStack {
                        Text(order.menuName)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Rp \(order.price),-")
                            .frame(width: 80, alignment: .trailing)
                        Text("x\(order.quantity)")
                            .frame(width: 40, alignment: .trailing)
                    }
                }
                
                Text("Current Total (estimation): Rp \(calculateTotal()),-")
                    .font(.headline)
                    .padding(.top)
                
                Button("Save Order") {
                    saveOrder()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding(.top)
            }
            .padding()
        }
        .padding()
    }
    
    private func bindingForMenu(_ name: String, price: Int) -> Binding<Int> {
        if let existingOrder = orderItems.first(where: { $0.menuName == name }) {
            return Binding(
                get: { existingOrder.quantity },
                set: { newValue in existingOrder.quantity = newValue }
            )
        } else {
            let newOrder = OrderItem(menuName: name, price: price)
            modelContext.insert(newOrder)
            return Binding(
                get: { newOrder.quantity },
                set: { newValue in newOrder.quantity = newValue }
            )
        }
    }
    
    private func calculateTotal() -> Int {
        return orderItems.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
    
    private func saveOrder() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save order: \(error)")
        }
    }
}

#Preview {
    MenuPage()
        .modelContainer(for: OrderItem.self, inMemory: true)
}
