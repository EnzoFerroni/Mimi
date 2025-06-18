//
//  MimiDreamsApp.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

// The main application entry point for MimiDreams
// Sets up the application environment and configures the Core Data stack
@main
struct MimiDreamsApp: App {
    // MARK: - Properties
    
    // Core Data persistence controller singleton for data management across the app
    let persistenceController = PersistenceController.shared
    
    // MARK: - App Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
