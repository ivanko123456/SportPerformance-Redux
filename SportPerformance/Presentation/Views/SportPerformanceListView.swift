//
//  SportPerformanceListView.swift
//  SportPerformance
//
//  Created by Ivan Fabri on 26/07/2025.
//

import SwiftUI

struct SportPerformanceListView: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        SportPerformanceListContentView(
            viewModel: SportPerformanceListViewModel(store: store)
        )
    }
}

struct SportPerformanceListContentView: View {
    @StateObject var viewModel: SportPerformanceListViewModel
    @State private var isAddPresented = false
    
    private var filterBinding: Binding<Filter> {
        Binding(
            get: { viewModel.filter },
            set: { viewModel.setFilter($0) }
        )
    }
    
    private func listItemView(_ performance: SportPerformance) -> some View {
        return VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(performance.name)
                    .font(.headline)
                Spacer()
                if performance.isLocal {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(.blue)
                } else {
                    Image(systemName: "cloud")
                        .foregroundColor(.green)
                }
            }
            
            HStack {
                Text(performance.place)
                    .font(.subheadline)
                Spacer()
                Text(performance.length, format: .number.precision(.fractionLength(2)))
                    .font(.subheadline)
                Text("m")
                    .font(.subheadline)
                
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Picker("", selection: filterBinding) {
                    ForEach(Filter.allCases) { Text($0.title).tag($0) }
                }
                .pickerStyle(.segmented)
                .padding([.horizontal, .top])
                
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else if let msg = viewModel.error {
                        Text(msg).foregroundColor(.red)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        if viewModel.items.isEmpty {
                            Text(L10n.SportPerformanceList.noSavedPerformance)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        } else {
                            List {
                                ForEach(viewModel.items) { performance in
                                    listItemView(performance)
                                }
                                .onDelete(perform: viewModel.delete)
                            }
                        }
                    }
                }
            }
            .navigationTitle(L10n.SportPerformanceList.navigationTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { isAddPresented.toggle() } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear { viewModel.load() }
            .sheet(
                isPresented: $isAddPresented,
                onDismiss: {
                    viewModel.setFilter(.all)
                    viewModel.load()
                }
            ) {
                NavigationView {
                    AddSportPerformanceView()
                }
            }
        }
    }
}

struct SportPerformanceListView_Previews: PreviewProvider {
    static var previews: some View {
        SportPerformanceListView()
            .environmentObject(AppDependencies.test.store)
    }
}
