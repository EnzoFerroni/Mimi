//
//  DreamCardView.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

struct DreamCardView: View {
    // Observed Core Data object
    @ObservedObject var dream: Item
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("SecondaryColor"))
                .opacity(0.4)
            VStack(alignment: .leading, spacing: 6) {
                // Dream title
                Text(dream.title ?? "No title")
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                // Dream description
                Text((dream.dreamText?.isEmpty ?? true) ? "(empty)" : dream.dreamText!)
                    .font(.body)
                    .lineLimit(3)
                    .truncationMode(.tail)
                Spacer(minLength: 0)
                // Dream type aligned center and bottom
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
        .clipped()
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let item = Item(context: context)
    return DreamCardView(dream: item)
}
