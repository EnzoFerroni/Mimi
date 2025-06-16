//
//  ContentView.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Core Data persistence controller singleton
    let persistenceController = PersistenceController.shared

    // MARK: - Body
    var body: some View {
        TabView {
            MimiView()
                .tabItem {
                    Image("mimi")
                    Text("Mimi")
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Dreams")
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

#Preview {
    ContentView()
}
