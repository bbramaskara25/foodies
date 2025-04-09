//
//  OrderConfirmationModal.swift
//  foodies
//
//  Created by Eliza Vornia on 08/04/25.
//

import SwiftUI

struct OrderConfirmationModal: View {
    @ObservedObject var stall: Stall
    @Binding var notes: String
    var orderItems: [OrderItem]
    var whatsAppNumber: String
    var estimatedTotal: Int
    var onPlaceOrder: () -> Void

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var showPlaceOrderAlert = false
    @State private var openWhatsApp = false

    var totalItems: Int {
        orderItems.reduce(0) { $0 + $1.quantity }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // HEADER
            Text("Order Confirmation")
                .font(.title)
                .bold()
                .padding(.top, 25) // atur jarak atas

            // NOTES
            VStack(alignment: .leading, spacing: 8) {
                Text("📝 Notes")
                    .font(.headline)
                TextField("e.g. No peanuts, spicy level 2", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            // ORDER SUMMARY
            VStack(alignment: .leading, spacing: 8) {
                Text("📋 Order Summary")
                    .font(.headline)

                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(orderItems) { order in
                            HStack {
                                Text(order.menuName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("x\(order.quantity)")
                                    .frame(width: 40, alignment: .center)
                                Text("Rp \(order.price * order.quantity),-")
                                    .frame(width: 100, alignment: .trailing)
                            }
                            .padding(.vertical, 4)
                            Divider()
                        }
                    }
                    .padding(.horizontal) // hindari terlalu banyak padding
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6).opacity(0.5))
                .cornerRadius(12)
            }

            Spacer() // untuk mendorong total & tombol ke bawah

            // TOTAL ITEMS + ESTIMASI
            VStack(alignment: .leading, spacing: 4) {
                Text("🍽️ Total Items: \(totalItems)")
                    .font(.headline)
                Text("💰 Estimated Total: Rp \(estimatedTotal.formatted(.number.grouping(.automatic))),-")
                    .font(.headline)
            }

            // PLACE ORDER BUTTON
            Button(action: {
                showPlaceOrderAlert = true
            }) {
                HStack {
                    Image(systemName: "paperplane.fill")
                    Text("Place Order via WhatsApp")
                        .bold()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .cornerRadius(12)
            }
        }
        .padding()
        .alert("Are you sure you want to place this order?", isPresented: $showPlaceOrderAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Yes") {
//<<<<<<< HEAD
                stall.wasOrdered = true
//=======
                let menuNames = orderItems.map { "\($0.menuName) x\($0.quantity)" }
                let order = UserOrder(menuItems: menuNames, notes: notes, total: estimatedTotal)
                modelContext.insert(order)

//>>>>>>> main
                onPlaceOrder()
                openWhatsApp = true
            }
        }
        .onChange(of: openWhatsApp) {
            if openWhatsApp {
                openWhatsAppURL()
            }
        }
    }

    private func openWhatsAppURL() {
        let text = """
        Halo 👋, saya ingin order. Berikut detailnya:
        \(orderItems.map { "- \($0.menuName) x\($0.quantity)" }.joined(separator: "\n"))
        \(notes.isEmpty ? "" : "\n📝 Catatan: \(notes)")

        Mohon infonya, total harga pastinya berapa ya? Terima kasih 🙏
        """

        guard let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://wa.me/\(whatsAppNumber)?text=\(encodedText)"),
              UIApplication.shared.canOpenURL(url) else {
            print("⚠️ Gagal membuat atau membuka URL WhatsApp")
            return
        }

        UIApplication.shared.open(url) { success in
            if success {
                print("✅ WhatsApp opened successfully")
            } else {
                print("❌ Failed to open WhatsApp")
            }
        }
    }
}

// Preview
struct OrderConfirmationModal_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State var notes: String = "Tanpa cabe"

        var body: some View {
            let previewStall = Stall(
                name: "Mie Ayam Bang Joko",
                images: ["kasturi", "kasturi"],
                rating: 4.6,
                location: "GOP 6",
                category: ["Mie", "Halal"],
                lowestPrice: 10000,
                highestPrice: 25000,
                menuList: [
                    Menu(name: "Mie Ayam", price: 15000),
                    Menu(name: "Bakso", price: 12000)
                ],
                whatsAppNumber: "6281234567890"
            )

            let previewOrderItems = [
                OrderItem(menuName: "Mie Ayam", price: 15000, quantity: 2),
                OrderItem(menuName: "Bakso", price: 12000, quantity: 1)
            ]

            return OrderConfirmationModal(
                stall: previewStall,
                notes: $notes,
                orderItems: previewOrderItems,
                whatsAppNumber: previewStall.whatsAppNumber,
                estimatedTotal: 42000,
                onPlaceOrder: {
                    print("🟢 Order placed in preview")
                }
            )
        }
    }
}


