//
//  AddDreamView.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

struct AddDreamView: View {
    // MARK: - Environment
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Public properties
    var selectedDate: Date
    var dreamToEdit: Item?
    var onDreamSaved: (() -> Void)? = nil
    
    // MARK: - State
    @State private var title: String
    @State private var dreamText: String
    @State private var date: Date
    @State private var dreamType: DreamType = .normal
    
    // MARK: - DreamType enum
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
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dream date")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color("Highlight"))) {
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                
                Section(header: Text("Title")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color("Highlight"))) {
                        TextField("Dream title", text: $title)
                    }
                
                Section(header: Text("Description")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color("Highlight"))) {
                        TextEditor(text: $dreamText)
                            .frame(height: 200)
                    }
                
                Section(header: Text("Type")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color("Highlight"))) {
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
        dream.setValue(dreamType.rawValue, forKey: "type")
        do {
            try viewContext.save()
            onDreamSaved?()
        } catch {
            print("Error saving dream: \(error.localizedDescription)")
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
