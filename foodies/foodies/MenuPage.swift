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
    @State private var orderItemsState: [OrderItem] = []  // Initialize order items state
    @State private var notes: String = ""
    
    var menuList: [(name: String, price: Int)]  // Assume menuList is an array of tuples
    
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
                            
                            // Picker untuk memilih kuantitas
                            Picker("Quantity", selection: bindingForMenu(menu.name, price: menu.price)) {
                                ForEach(0..<10, id: \.self) { num in
                                    Text("\(num)")
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: bindingForMenu(menu.name, price: menu.price).wrappedValue) { _ in
                                updateTotal()  // Update total setiap kali kuantitas berubah
                            }
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
                
                // Menampilkan Order Summary berdasarkan state kuantitas
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
                
                // Menampilkan Total Harga
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
        .onAppear {
            // Inisialisasi dengan menu kosong (bisa diganti jika Anda ingin memuat data dari suatu tempat)
            orderItemsState = menuList.map { OrderItem(menuName: $0.name, price: $0.price) }
        }
    }
    
    // Fungsi untuk mengikat kuantitas menu
    private func bindingForMenu(_ name: String, price: Int) -> Binding<Int> {
        if let existingOrder = orderItemsState.first(where: { $0.menuName == name }) {
            return Binding(
                get: { existingOrder.quantity },
                set: { newValue in
                    existingOrder.quantity = newValue
                    updateTotal()  // Update total setelah kuantitas berubah
                }
            )
        } else {
            // Tambahkan menu baru jika tidak ada dalam orderItemsState
            let newOrder = OrderItem(menuName: name, price: price)
            orderItemsState.append(newOrder)
            return Binding(
                get: { newOrder.quantity },
                set: { newValue in
                    newOrder.quantity = newValue
                    updateTotal()  // Update total setelah kuantitas berubah
                }
            )
        }
    }
    
    // Kalkulasi total harga berdasarkan kuantitas
    private func calculateTotal() -> Int {
        return orderItemsState.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
    
    // Fungsi untuk menyimpan pesanan
    private func saveOrder() {
        do {
            try modelContext.save()
            print("Order saved successfully")
        } catch {
            print("Failed to save order: \(error)")
        }
    }

    // Fungsi untuk memperbarui total harga saat ada perubahan
    private func updateTotal() {
        // Trigger perhitungan ulang total
        let total = calculateTotal()
        print("Updated total: \(total)")  // Debugging output untuk melihat total
    }
}

#Preview {
    MenuPage(menuList: [
        ("Nasi Goreng", 25000),
        ("Mie Ayam", 20000),
        ("Bakso", 18000),
        ("Sate", 22000)
    ])
        .modelContainer(for: OrderItem.self, inMemory: true)
}
