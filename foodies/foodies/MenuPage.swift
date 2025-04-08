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

    var stall: Stall

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    StallHeaderView(stall: stall)
                    menuListView
                }
                .padding(.horizontal)
            }

            Divider()

            TotalView(
                total: calculateTotal(),
                onSave: {
                    showConfirmationModal = true
                }
            )
            .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            orderItemsState = stall.menuList.map {
                OrderItem(menuName: $0.name, price: Int($0.price))
            }
        }
        .sheet(isPresented: $showConfirmationModal) {
            OrderConfirmationModal(
                notes: $notes,
                orderItems: orderItemsState.filter { $0.quantity > 0 },
                whatsAppNumber: stall.whatsAppNumber,
                estimatedTotal: calculateTotal(),
                onPlaceOrder: {
                    saveOrder()
                    showConfirmationModal = false
                }
            )
            
        }
    }

    // Menu List
    private var menuListView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Menu Item")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                Text("Price")
                    .frame(width: 80, alignment: .leading)
                    .bold()
                Text("Quantity")
                    .frame(width: 120, alignment: .trailing)
                    .bold()
            }
            .padding(.horizontal)

            ForEach(stall.menuList, id: \.name) { menu in
                VStack(spacing: 4) {
                    HStack {
                        Text(menu.name)
                            .frame(maxWidth: 150, alignment: .leading)
                        Text("Rp \(menu.price.formatted(.number.grouping(.automatic))),-")
                            .frame(width: 100, alignment: .leading)

                        CustomStepper(value: bindingForMenu(menu.name, price: Int(menu.price)))
                            .frame(width: 120, alignment: .trailing)
                    }
                    .padding(.horizontal)

                    Divider()
                }
            }
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
        orderItemsState.reduce(0) { $0 + ($1.price * $1.quantity) }
    }

    private func updateTotal() {
        let total = calculateTotal()
        print("\u{1F4B0} Updated total: \(total)")
    }

    private func saveOrder() {
        do {
            try modelContext.save()
            print("\u{2705} Order saved successfully")
        } catch {
            print("\u{274C} Failed to save order: \(error)")
        }
    }
}

#Preview {
    MenuPage(stall: Stall.all[0])
        .modelContainer(for: OrderItem.self, inMemory: true)
}
