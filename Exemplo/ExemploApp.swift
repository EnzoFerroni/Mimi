//
//  ExemploApp.swift
//  Exemplo
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

@main
struct ExemploApp: App {
    // Core Data persistence controller singleton
    let persistenceController = PersistenceController.shared
    @State private var selectedTab = 0

    var body: some Scene {
        WindowGroup {
            RootTabView(selectedTab: .init(get: { selectedTab }, set: { selectedTab = $0 }))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct RootTabView: View {
    @Binding var selectedTab: Int
    var body: some View {
        TabView(selection: $selectedTab) {
            CalendarView(onDreamAdded: {
                NotificationCenter.default.post(name: .dreamAdded, object: nil)
                selectedTab = 1 // Go to Mimi tab
            })
            .tabItem {
                Image(systemName: "calendar")
                Text("Dreams")
            }
            .tag(0)
            MimiView()
                .tabItem {
                    Image(systemName: "face.smiling")
                    Text("Mimi")
                }
                .tag(1)
        }
    }
}
