//
//  ContentView.swift
//  foodies
//
//  Created by Bryan Bramaskara on 20/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Time]
    
    @AppStorage("userName") private var userName: String = ""
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                // Header View
                headerView
                
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        EditButton()
//                    }
//                    ToolbarItem {
//                        Button(action: addItem) {
//                            Label("Add Item", systemImage: "plus")
//                        }
//                    }
//                }
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear {
            promptForUserName()
        }
    }
    
    // Header View
    private var headerView: some View {
        HStack {
            // Logo on the left
            Image("foodies") // Ensure "logo.png" exists in your assets
                .resizable()
                .frame(width: 80, height: 25)
                .padding(.leading)


            // Greeting Message with User's Name
            Text("\(greetingMessage), \(userName)!")
                .font(.headline)
                .padding(.horizontal)
                .foregroundColor(.white)

            Spacer()
        }
        .padding(.vertical)
        .background(Color(hex: "13A435")) // Optional background color
    }

    // Dynamic Greeting
    private var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<21:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }

    // Add Item Function
    private func addItem() {
        withAnimation {
            let newItem = Time(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    // Delete Item Function
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }

    // Asking for User's Name
    private func promptForUserName() {
        if userName.isEmpty {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Welcome!", message: "Please enter your name:", preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.placeholder = "Your Name"
                }
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    if let inputText = alert.textFields?.first?.text, !inputText.isEmpty {
                        userName = inputText
                    }
                })

                // Presenting the alert through the root view controller
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.present(alert, animated: true)
                }
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Time.self, inMemory: true)
}
