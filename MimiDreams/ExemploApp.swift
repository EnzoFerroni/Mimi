//
//  ExemploApp.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

@main
struct ExemploApp: App {
    // MARK: - Core Data persistence controller singleton
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
            MimiView()
                .tabItem {
                    Image("mimi")
                    Text("Mimi")
                }
                .tag(0)
            CalendarView()
            .tabItem {
                Image(systemName: "calendar")
                Text("Dreams")
            }
            .tag(1)
        }
    }
}
