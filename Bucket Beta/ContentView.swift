//
//  ContentView.swift
//  Bucket Beta
//
//  Created by Alex Clark on 1/11/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: ActivityViewModel
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.activities) { activity in
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(activity.title)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                if activity.completionCount > 0 {
                                    Text("Completed \(activity.completionCount) time\(activity.completionCount == 1 ? "" : "s")")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .tint(Color("BucketGold"))
                    }
                    .onDelete { indexSet in
                        viewModel.deleteActivities(at: indexSet)
                    }
                    .onMove { indices, newOffset in
                        viewModel.moveActivity(from: indices, to: newOffset)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("My Bucket")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation {
                                editMode = editMode.isEditing ? .inactive : .active
                            }
                        }) {
                            Text(editMode.isEditing ? "Done" : "Edit")
                                .foregroundColor(Color("BucketGold"))
                                .frame(minWidth: 44, minHeight: 44)
                        }
                    }
                }
                .environment(\.editMode, $editMode)
                .tint(Color("BucketGold"))
                
                if !editMode.isEditing {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: { viewModel.showingNewActivitySheet = true }) {
                                Image(systemName: "plus")
                                    .font(.title.bold())
                                    .foregroundColor(.white)
                                    .frame(width: 64, height: 64)
                                    .background(Color("BucketGold"))
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                            }
                            .padding(.trailing, 24)
                            .padding(.bottom, 24)
                            .accessibilityLabel("Add new activity")
                        }
                    }
                }
            }
        }
        .tint(Color("BucketGold"))
        .sheet(isPresented: $viewModel.showingNewActivitySheet) {
            ActivityFormView(mode: .add)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ActivityViewModel())
}
