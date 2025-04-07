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
    @State private var orderItemsState: [OrderItem] = []
    @State private var notes: String = ""
    @State private var showConfirmationModal = false

    var menuList: [(name: String, price: Int)]
    var whatsAppNumber: String

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(menuList, id: \.name) { menu in
                        HStack {
                            Text(menu.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Rp \(menu.price),-")
                                .frame(width: 80, alignment: .trailing)
                            Picker("Quantity", selection: bindingForMenu(menu.name, price: menu.price)) {
                                ForEach(0..<10, id: \.self) { num in
                                    Text("\(num)")
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(.horizontal)
                    }
                }
            }

            VStack(alignment: .leading) {
                Text("Notes:")
                    .font(.headline)
                TextField("Enter your notes here", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)

                Text("Order Summary")
                    .font(.headline)

                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(orderItemsState.filter { $0.quantity > 0 }) { order in
                            HStack {
                                Text(order.menuName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Rp \(order.price),-")
                                    .frame(width: 80, alignment: .trailing)
                                Text("x\(order.quantity)")
                                    .frame(width: 40, alignment: .trailing)
                            }
                        }
                    }
                }
                .frame(maxHeight: 150)

                Text("Current Total (estimation): Rp \(calculateTotal()),-")
                    .font(.headline)
                    .padding(.top)

                Button("Save Order") {
                    showConfirmationModal = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding(.top)
            }
            .padding()
            .background(Color.gray.opacity(0.15))
            .cornerRadius(12)
        }
        .padding()
        .onAppear {
            orderItemsState = menuList.map { OrderItem(menuName: $0.name, price: $0.price) }
            print("📱 WhatsApp Nomor: \(whatsAppNumber)") // ✅ fixed
        }
        .sheet(isPresented: $showConfirmationModal) {
            OrderConfirmationModal(
                notes: notes,
                orderItems: orderItemsState.filter { $0.quantity > 0 },
                whatsAppNumber: whatsAppNumber, // ✅ fixed
                onPlaceOrder: {
                    saveOrder()
                    showConfirmationModal = false
                }
            )
        }
    }

    private func bindingForMenu(_ name: String, price: Int) -> Binding<Int> {
        if let index = orderItemsState.firstIndex(where: { $0.menuName == name }) {
            return Binding(
                get: { orderItemsState[index].quantity },
                set: { newValue in
                    orderItemsState[index].quantity = newValue
                    updateTotal()
                }
            )
        } else {
            let newOrder = OrderItem(menuName: name, price: price)
            DispatchQueue.main.async {
                orderItemsState.append(newOrder)
            }
            return Binding(
                get: { newOrder.quantity },
                set: { newValue in
                    newOrder.quantity = newValue
                    updateTotal()
                }
            )
        }
    }

    private func calculateTotal() -> Int {
        return orderItemsState.reduce(0) { $0 + ($1.price * $1.quantity) }
    }

    private func saveOrder() {
        do {
            try modelContext.save()
            print("✅ Order saved successfully")
        } catch {
            print("❌ Failed to save order: \(error)")
        }
    }

    private func updateTotal() {
        let total = calculateTotal()
        print("💰 Updated total: \(total)")
    }
}

#Preview {
    MenuPage(
        menuList: [
            ("Nasi Goreng", 25000),
            ("Mie Ayam", 20000),
            ("Bakso", 18000)
        ],
        whatsAppNumber: "6281234567890" // ✅ fixed argument label
    )
    .modelContainer(for: OrderItem.self, inMemory: true)
}
