//
//  foodiesApp.swift
//  foodies
//
//  Created by Bryan Bramaskara on 20/03/25.
//

import SwiftUI
import SwiftData

@main
struct foodiesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            StallsPage()
        }
        .modelContainer(sharedModelContainer)
    }
}
