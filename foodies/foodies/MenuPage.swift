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

extension View {
    func hideKeyboardOnTap() -> some View {
        self.gesture(
            TapGesture().onEnded {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil, from: nil, for: nil
                )
            }
        )
    }
}

struct MenuPage: View {
    @Environment(\.modelContext) private var modelContext
    @State private var orderItemsState: [OrderItem] = []
    @State private var notes: String = ""
    @State private var showConfirmationModal = false
    @State private var showQuantityAlert = false
    @ObservedObject var stall: Stall

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    StallHeaderView(stall: stall)

                    // Separator dengan shadow
                    Divider()
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)

                    menuListView
                }
                .padding(.horizontal)
            }

            Divider()

            TotalView(
                total: calculateTotal(),
                onSave: {
                    if orderItemsState.contains(where: { $0.quantity > 0 }) {
                        showConfirmationModal = true
                    } else {
                        showQuantityAlert = true
                    }
                }
            )
            .frame(maxWidth: .infinity)
        }
        .hideKeyboardOnTap()
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            orderItemsState = stall.menuList.map {
                OrderItem(menuName: $0.name, price: Int($0.price))
            }
        }
        .sheet(isPresented: $showConfirmationModal) {
            OrderConfirmationModal(
                stall: stall,
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
        .alert("Oops.. pilih menu dulu yuk!", isPresented: $showQuantityAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Anda belum memilih menu apapun.")
        }
    }

    // Menu List
    private var menuListView: some View {
        ForEach(stall.menuList, id: \.name) { menu in
            VStack(spacing: 4) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(menu.name)
                            .font(.headline)
                        Text("Rp \(menu.price.formatted(.number.grouping(.automatic)))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    CustomStepper(value: bindingForMenu(menu.name, price: Int(menu.price)))
                }
                .padding(.horizontal)

                Divider()
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
        print("💰 Updated total: \(total)")
    }

    private func saveOrder() {
        do {
            try modelContext.save()
            print("✅ Order saved successfully")
        } catch {
            print("❌ Failed to save order: \(error)")
        }
    }
}

#Preview {
    MenuPage(stall: Stall.all[0])
        .modelContainer(for: OrderItem.self, inMemory: true)
}
