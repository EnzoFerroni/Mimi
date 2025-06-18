//
//  DreamCardView.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

// A card view that displays a summary of a dream's details
// Used in the horizontal scrolling list in CalendarView
struct DreamCardView: View {
    // MARK: - Properties
    
    // Core Data dream object to be displayed
    // ObservedObject to update automatically when dream data changes
    @ObservedObject var dream: Item
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Card background with rounded corners and partial transparency
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("SecondaryColor"))
                .opacity(0.4)
            
            // Content layout with vertical arrangement
            VStack(alignment: .leading, spacing: 6) {
                // Dream title with overflow handling
                // Falls back to "No title" if title is nil
                Text(dream.title ?? "No title")
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                // Dream description with overflow handling
                // Shows "(empty)" if no text exists or is empty
                Text((dream.dreamText?.isEmpty ?? true) ? "(empty)" : (dream.dreamText ?? ""))
                    .font(.body)
                    .lineLimit(3)
                    .truncationMode(.tail)
                
                Spacer(minLength: 0)
                
                // Dream type label at bottom if available
                // Only shown if type exists and isn't empty
                if let type = dream.type, !type.isEmpty {
                    HStack() {
                        Spacer()
                        Text(type)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        Spacer()
                    }
                }
            }
            .padding(8)
        }
        .frame(width: 200, height: 100)
        .clipped() // Ensures content doesn't overflow the card boundaries
    }
}

// Preview with a sample dream from the preview Core Data context
#Preview {
    let context = PersistenceController.preview.container.viewContext
    let item = Item(context: context)
    item.title = "Sample Dream"
    item.dreamText = "This is a sample dream for preview purposes."
    item.type = "Lucid😐"
    return DreamCardView(dream: item)
}
