import SwiftUI

enum FormMode: Equatable {
    case add
    case edit(Activity)
}

struct ActivityFormView: View {
    let mode: FormMode
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: ActivityViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var websiteURL = ""
    @State private var instagramURL = ""
    @State private var address = ""
    @State private var beliURL = ""
    @FocusState private var isTitleFocused: Bool
    
    private var existingActivity: Activity? {
        if case .edit(let activity) = mode {
            return activity
        }
        return nil
    }
    
    var actionButtonTitle: String {
        switch mode {
        case .add: return "Add"
        case .edit: return "Save"
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Title", text: $title)
                            .focused($isTitleFocused)
                            .font(.body.bold())
                        
                        TextField("Description (Optional)", text: $description, axis: .vertical)
                    } header: {
                        Text("Activity Details")
                    }
                    
                    Section {
                        TextField("Website URL (Optional)", text: $websiteURL)
                        TextField("Instagram URL (Optional)", text: $instagramURL)
                        TextField("Beli URL (Optional)", text: $beliURL)
                    } header: {
                        Text("Links (Optional)")
                    }
                    
                    Section {
                        TextField("Address (Optional)", text: $address)
                    } header: {
                        Text("Location (Optional)")
                    }
                }
                
                // Add/Save button at bottom
                VStack {
                    Button(action: {
                        let activity = Activity(
                            id: existingActivity?.id ?? UUID(),
                            title: title,
                            description: description.isEmpty ? nil : description,
                            websiteURL: websiteURL.isEmpty ? nil : websiteURL,
                            instagramURL: instagramURL.isEmpty ? nil : instagramURL,
                            address: address.isEmpty ? nil : address,
                            beliURL: beliURL.isEmpty ? nil : beliURL,
                            completionCount: existingActivity?.completionCount ?? 0,
                            notes: existingActivity?.notes ?? []
                        )
                        
                        if case .edit = mode {
                            viewModel.updateActivity(activity)
                        } else {
                            viewModel.addActivity(activity)
                        }
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle")
                            Text(actionButtonTitle)
                        }
                        .font(.headline)
                        .foregroundColor(Color("BucketGold"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color("BucketGold").opacity(0.15))
                        .cornerRadius(12)
                    }
                    .disabled(title.isEmpty)
                    .padding()
                }
            }
            .navigationTitle(mode == .add ? "New Activity" : "Edit Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            if let activity = existingActivity {
                title = activity.title
                description = activity.description ?? ""
                websiteURL = activity.websiteURL ?? ""
                instagramURL = activity.instagramURL ?? ""
                address = activity.address ?? ""
                beliURL = activity.beliURL ?? ""
            } else {
                // Auto-focus title field only for new activities
                isTitleFocused = true
            }
        }
    }
} 