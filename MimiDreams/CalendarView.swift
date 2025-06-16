//
//  CalendarView.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI
import CoreData

struct CalendarView: View {
    // MARK: - Environment
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - State
    @State private var selectedDate = Date()
    @State private var showAddDream = false
    @State private var editDream: Item? = nil
    @State private var dreamCounts: [PostCount] = []
        
    // MARK: - Filtered dreams for the selected date
    private var dreamsForSelectedDate: [Item] {
        items.filter { item in
            guard let date = item.timestamp else { return false }
            return Calendar.current.isDate(date, inSameDayAs: selectedDate)
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack(){
                Color("Background")
                    .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color("SecondaryColor"))
                            .opacity(0.2)
                            .frame(width: .infinity, height: 380)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 1)
                            )
                        DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding(.horizontal)
                    }
                    .padding(.leading , 10)
                    .padding(.trailing , 10)
                    
                    if dreamsForSelectedDate.isEmpty {
                        Text("No dreams for this day.")
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        // Dreams grid
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(dreamsForSelectedDate) { dream in
                                    Button {
                                        editDream = dream
                                    } label: {
                                        DreamCardView(dream: dream)
                                            .frame(width: 200, height: 100)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 8)
                        }
                    }
                    
                    // Pie chart below dream cards
                    PieChartView(data: dreamCounts)
                        .frame(height: 400)
                    
                    Spacer()
                }
            }
        }
            .navigationTitle("Dreams")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddDream = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            } .toolbarBackground(Color("Background"), for: .navigationBar)
            .sheet(isPresented: $showAddDream, onDismiss: fetchDreamCounts) {
                AddDreamView(selectedDate: selectedDate, onDreamSaved: {
                    fetchDreamCounts()
                })
                .environment(\.managedObjectContext, viewContext)
            }
            .sheet(item: $editDream, onDismiss: {
                self.selectedDate = self.selectedDate
                self.editDream = nil
                fetchDreamCounts()
            }) { editDream in
                AddDreamView(selectedDate: editDream.timestamp ?? Date(), dreamToEdit: editDream, onDreamSaved: {
                    fetchDreamCounts()
                })
                .environment(\.managedObjectContext, viewContext)
            }
            .onAppear(perform: fetchDreamCounts)
            .onChange(of: items.map(\.objectID)) { fetchDreamCounts() }
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
    
    // MARK: - Fetch dream counts by type
    private func fetchDreamCounts() {
        let categories = [
            "Confort😃",
            "Nightmare🙁",
            "Lucid😐",
            "Symbolic💭"
        ]
        var counts: [PostCount] = []
        for category in categories {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
            request.predicate = NSPredicate(format: "type == %@", category)
            do {
                let count = try viewContext.count(for: request)
                counts.append(PostCount(category: category, count: count))
            } catch {
                counts.append(PostCount(category: category, count: 0))
            }
        }
        dreamCounts = counts
    }
}

#Preview {
    CalendarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
