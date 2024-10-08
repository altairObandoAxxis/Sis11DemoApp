//
//  EquityDemoAppApp.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 18/9/24.
//

import SwiftUI
import SwiftData

@main
struct EquityDemoAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Sis11AuthData.self
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
