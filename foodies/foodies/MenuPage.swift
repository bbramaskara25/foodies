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

//    var menuList: [(name: String, price: Int)]
//    var whatsAppNumber: String
    var stall: Stall

    var body: some View {
        // Stall Detail Section
        VStack(spacing: 10) {
            
                HStack{
                    Image(stall.images[0])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .padding(10)
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text(stall.name)
                                .font(.headline)
                            
                            Spacer()
                               
                        }
                        
                        HStack{
                            Image(systemName: "pin.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.orange)
                            Text(stall.location)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                            HStack{
                                Image(systemName: "wallet.bifold.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.orange)
                                    .frame(width: 14, height: 14)
                                
                                Text("5K-20K")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                            }
                        HStack{
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.orange)
                            Text(String(stall.rating))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                    }
                }
    }
        
        // Menu Section
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Menu Item")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold(true)
                        Text("Price")
                            .frame(width: 80, alignment: .leading)
                            .bold(true)
                        Text("Quantity")
                            .frame(width: 100, alignment: .trailing)
                            .bold(true)
                    }
                    .padding(.horizontal)
                    ForEach(stall.menuList, id: \.name) { menu in
                        HStack {
                            Text(menu.name)
                                .frame(maxWidth: 150, alignment: .leading)
                            Text("Rp \(menu.price.formatted(.number.grouping(.automatic))),-")
                                .frame(width: 100, alignment: .leading)
                            Picker("Quantity", selection: bindingForMenu(menu.name, price: Int(menu.price))) {
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

            // Total and Save Section
            VStack(alignment: .leading) {
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
            orderItemsState = stall.menuList.map { OrderItem(menuName: $0.name, price: Int($0.price)) }
            print("📱 WhatsApp Nomor: \(stall.whatsAppNumber)") // ✅ fixed
        }
        .sheet(isPresented: $showConfirmationModal) {
            OrderConfirmationModal(
                notes: $notes,
                orderItems: orderItemsState.filter { $0.quantity > 0 },
                whatsAppNumber: stall.whatsAppNumber, // ✅ fixed
                estimatedTotal: calculateTotal(),
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
        stall: Stall.all[0]
    )
    .modelContainer(for: OrderItem.self, inMemory: true)
}
