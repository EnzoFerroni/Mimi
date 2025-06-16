//
//  Persistence.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 04/06/25.
//

import CoreData

struct PersistenceController {
    // Singleton instance
    static let shared = PersistenceController()

//     Preview instance for SwiftUI previews
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<2 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    // Persistent container for Core Data
    let container: NSPersistentCloudKitContainer

    // MARK: - Initializer
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "MimiDreams")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
