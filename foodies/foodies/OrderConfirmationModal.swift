//
//  OrderConfirmationModal.swift
//  foodies
//
//  Created by Eliza Vornia on 06/04/25.
//
import SwiftUI

struct OrderConfirmationModal: View {
    var notes: String
    var orderItems: [OrderItem]
    var whatsAppNumber: String
    var onPlaceOrder: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var showPlaceOrderAlert = false
    @State private var openWhatsApp = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Order Confirmation")
                .font(.title)
                .bold()

            VStack(alignment: .leading, spacing: 8) {
                Text("Notes:")
                    .font(.headline)
                Text(notes.isEmpty ? "No notes provided" : notes)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }

            Text("Order Summary")
                .font(.headline)

            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(orderItems) { order in
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
                .padding()
            }
            .frame(width: 350, height: 500)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)

            Spacer()

            Button(action: {
                showPlaceOrderAlert = true
            }) {
                Text("Place Order")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
            }
        }
        .padding()
        .alert("Are you sure want to place order?", isPresented: $showPlaceOrderAlert) {
            Button("No", role: .cancel) {}
            Button("Yes") {
                onPlaceOrder()
                openWhatsApp = true
            }
        }
        .onChange(of: openWhatsApp) { newValue in
            if newValue {
                openWhatsAppURL()
            }
        }
    }

    private func openWhatsAppURL() {
        let text = """
        Hallo, saya ingin order:
        \(orderItems.map { "- \($0.menuName) x\($0.quantity)" }.joined(separator: "\n"))
        \(notes.isEmpty ? "" : "\n\nCatatan: \(notes)")
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


#Preview {
    OrderConfirmationModal(
        notes: "Extra spicy please!",
        orderItems: [
            OrderItem(menuName: "Nasi Goreng", price: 25000, quantity: 2),
            OrderItem(menuName: "Mie Ayam", price: 20000, quantity: 1)
        ],
        whatsAppNumber: "6281234567890",
        onPlaceOrder: { print("Order placed") }
    )
}
