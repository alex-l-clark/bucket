import SwiftUI

struct CompletionView: View {
    let activity: Activity
    @State private var note = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: ActivityViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Note input area
                Form {
                    Section {
                        TextEditor(text: $note)
                            .frame(minHeight: 100)
                            .overlay(
                                Group {
                                    if note.isEmpty {
                                        Text("Add a note (optional)")
                                            .foregroundColor(.secondary)
                                            .padding(.top, 8)
                                            .padding(.leading, 5)
                                            .allowsHitTesting(false)
                                    }
                                },
                                alignment: .topLeading
                            )
                    } header: {
                        Text("What did you think?")
                    }
                }
                
                // Save button at bottom
                VStack {
                    Button(action: {
                        viewModel.completeActivity(activity, note: note)
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle")
                            Text("Save")
                        }
                        .font(.headline)
                        .foregroundColor(Color("BucketGold"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color("BucketGold").opacity(0.15))
                        .cornerRadius(12)
                    }
                    .padding()
                }
            }
            .navigationTitle("Complete Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
} 