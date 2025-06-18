//
//  CoreDataExtensions.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 18/06/25.
//

import CoreData

// Utility extensions for Core Data components
extension NSManagedObjectContext {
    // Safely saves changes to the context with error handling
    // Returns true if save was successful, false if an error occurred
    @discardableResult
    func saveContext() -> Bool {
        guard hasChanges else { return true }
        
        do {
            try save()
            return true
        } catch {
            print("Error saving context: \(error)")
            return false
        }
    }
}
