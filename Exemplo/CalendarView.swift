//
//  ContentView.swift
//  Exemplo
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI
import CoreData


struct CalendarView: View {
    // Core Data context for persistence
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - UI State
    @State private var selectedDate = Date() // Selected date in the calendar
    @State private var showAddDream = false  // Controls the add dream sheet
    @State private var editDream: Item? = nil // Dream to be edited
    
    
    // Callback to notify when a dream is added
    var onDreamAdded: (() -> Void)? = nil
    
    // MARK: - Filtered dreams for the selected date
    private var dreamsForSelectedDate: [Item] {
        items.filter { item in
            guard let date = item.timestamp else { return false }
            return Calendar.current.isDate(date, inSameDayAs: selectedDate)
        }
    }
    
    // MARK: - Delete a dream from Core Data
    private func deleteDream(_ dream: Item) {
        withAnimation {
            viewContext.delete(dream)
            do {
                try viewContext.save()
            } catch {
                print("Error deleting dream: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(){
                VStack(spacing: 16) {
                    ZStack(){
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color("SecondaryColor"))
                            .opacity(0.2)
                            .frame(width: .infinity , height: 400)
                        DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding(.horizontal)
                        .colorScheme(.dark)                    }
                    if dreamsForSelectedDate.isEmpty {
                        Text("No dreams for this day.")
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        // Dreams grid
                        ScrollView(.horizontal , showsIndicators: false) {
                            HStack {
                                ForEach(dreamsForSelectedDate) { dream in
                                    // Open edit sheet when tapping a card
                                    Button {
                                        editDream = dream
                                    } label: {
                                        DreamCardView(dream: dream)
                                            .frame(width: 200, height: 100)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 8)}
                    }
                    Spacer()
                }
            }
                .background(Color("Background"))
                .navigationTitle("Sonhos")
                .toolbar {
                    // Add dream button in the navigation bar
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddDream = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                // Sheet to add a new dream
                .sheet(isPresented: $showAddDream) {
                    AddDreamView(selectedDate: selectedDate, onDreamSaved: {
                        onDreamAdded?()
                    })
                    .environment(\.managedObjectContext, viewContext)
                }
                // Sheet to edit a dream
                .sheet(item: $editDream, onDismiss: {
                    self.selectedDate = self.selectedDate
                    self.editDream = nil
                }) { editDream in
                    AddDreamView(selectedDate: editDream.timestamp ?? Date(), dreamToEdit: editDream)
                        .environment(\.managedObjectContext, viewContext)
                }
            }
        }
    }


#Preview {
    CalendarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
