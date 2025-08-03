//
//  AddSportPerformanceView.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import SwiftUI


struct AddSportPerformanceView: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        AddSportPerformanceContentView(
            viewModel: AddSportPerformanceViewModel(store: store)
        )
    }
}

struct AddSportPerformanceContentView: View {
    
    private enum Field: Hashable {
        case name, place, length
    }
    
    @StateObject var viewModel: AddSportPerformanceViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    
    var body: some View {
        Form {
            TextField(L10n.AddSportPerformance.namePlaceholder, text: $viewModel.name)
                .focused($focusedField, equals: .name)
                .submitLabel(.next)
                .onSubmit { focusedField = .place }
                .onChange(of: viewModel.name) { newName, _ in
                    viewModel.setName(newName)
                }
            
            TextField(L10n.AddSportPerformance.placePlaceholder, text: $viewModel.place)
                .focused($focusedField, equals: .place)
                .submitLabel(.next)
                .onSubmit { focusedField = .length }
                .onChange(of: viewModel.place) { newPlace, _ in
                    viewModel.setPlace(newPlace)
                }
            
            TextField(L10n.AddSportPerformance.lengthPlaceholder, text: $viewModel.length)
                .keyboardType(.decimalPad)
                .focused($focusedField, equals: .length)
                .submitLabel(.done)
                .onSubmit {
                    focusedField = nil
                }
                .onChange(of: viewModel.length) { newLength, _ in
                    viewModel.setLength(newLength)
                }
            
            Picker("", selection: $viewModel.saveMode) {
                ForEach(SaveMode.allCases, id: \.self) { mode in
                    Text(mode.title).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: viewModel.saveMode) { newSaveMode, _ in
                viewModel.setSaveMode(newSaveMode)
            }
        }
        .navigationTitle(L10n.AddSportPerformance.navigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(L10n.AddSportPerformance.saveButton) {
                    Task {
                        await viewModel.save()
                    }
                }
                .disabled(!viewModel.isValid || viewModel.isSaving)
            }
            if focusedField == .length {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(L10n.AddSportPerformance.doneButton) {
                        focusedField = nil
                    }
                }
            }
        }
        .alert(item: $viewModel.error) { err in
            Alert(title: Text(err.localizedDescription), dismissButton: .default(Text(L10n.AddSportPerformance.okButton)))
        }
        .onAppear {
            focusedField = .name
        }
        .onDisappear {
            viewModel.reset()
        }
        .onReceive(viewModel.$didSave) { didSave in
            if didSave {
                dismiss()
            }
        }
    }
}

struct AddSportPerformanceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddSportPerformanceView()
                .environmentObject(AppDependencies.test.store)
        }
    }
}
