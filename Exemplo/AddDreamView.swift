//
//  AddDreamView.swift
//  Exemplo
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

struct AddDreamView: View {
    // Core Data context
    @Environment(\.managedObjectContext) private var viewContext
    // Dismiss control
    @Environment(\.dismiss) private var dismiss
    
    // Public properties
    var selectedDate: Date
    var dreamToEdit: Item?
    
    // Form states
    @State private var title: String
    @State private var dreamText: String
    @State private var date: Date
    @State private var dreamType: DreamType = .normal
    
    var onDreamSaved: (() -> Void)? = nil
    
    enum DreamType: String, CaseIterable, Identifiable {
        case normal = "Confort😃"
        case nightmare = "Nightmare🙁"
        case lucid =  "Lucid😐"
        case symbolic = "Symbolic💭"
        var id: String { self.rawValue }
    }
    
    // MARK: - Initializer
    init(selectedDate: Date, dreamToEdit: Item? = nil, onDreamSaved: (() -> Void)? = nil) {
        self.selectedDate = selectedDate
        self.dreamToEdit = dreamToEdit
        self.onDreamSaved = onDreamSaved
        _title = State(initialValue: dreamToEdit?.title ?? "")
        _dreamText = State(initialValue: dreamToEdit?.dreamText ?? "")
        _date = State(initialValue: dreamToEdit?.timestamp ?? selectedDate)
        _dreamType = State(initialValue: DreamType(rawValue: dreamToEdit?.type ?? "") ?? .normal)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dream date").font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color("Highlight")) ) {
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                Section(header: Text("Title").font(.system(size: 15 , weight: .bold))
                    .foregroundStyle(Color("Highlight")) ){
                    TextField("Dream title", text: $title)
                }
                Section(header: Text("Description").font(.system(size: 15 , weight: .bold))
                    .foregroundStyle(Color("Highlight")) ) {
                    TextEditor(text: $dreamText)
                        .frame(height: 200)
                }
                
                Section(header: Text("Type") .font(.system(size: 15 , weight: .bold))
                    .foregroundStyle(Color("Highlight")) ) {
                    Picker("Type", selection: $dreamType) {
                        ForEach(DreamType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .background(Color("Background"))
            .navigationTitle(dreamToEdit == nil ? "New Dream" : "Edit Dream")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveDream()
                        dismiss()
                    }
                    .disabled(title.isEmpty || dreamText.isEmpty)
                }
                if dreamToEdit != nil {
                    ToolbarItem(placement: .bottomBar) {
                        Button(role: .destructive) {
                            deleteDream()
                            dismiss()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
    // MARK: - Private methods
    private func saveDream() {
        let dream = dreamToEdit ?? Item(context: viewContext)
        dream.title = title
        dream.dreamText = dreamText
        dream.timestamp = date
        dream.setValue(dreamType.rawValue, forKey: "type") // Save type as string
        do {
            try viewContext.save()
            onDreamSaved?() // Notify when a dream is saved
        } catch {
            print("Erro ao salvar sonho: \(error.localizedDescription)")
        }
    }
    
    private func deleteDream() {
        guard let dream = dreamToEdit else { return }
        viewContext.delete(dream)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting dream: \(error.localizedDescription)")
        }
    }
}

#Preview {
    AddDreamView(selectedDate: Date(), dreamToEdit: nil)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
