//
//  ContentView.swift
//  Exemplo
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

struct ContentView: View {
    // Core Data persistence controller singleton
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView {
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Dreams")
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            MimiView()
                .tabItem {
                    Image("mimi")
                    Text("Mimi")
                }
        }
    }
}

#Preview {
    ContentView()
}
