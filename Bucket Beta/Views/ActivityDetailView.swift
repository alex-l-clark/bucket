import SwiftUI

struct ActivityDetailView: View {
    let activity: Activity
    @EnvironmentObject private var viewModel: ActivityViewModel
    @State private var showingEditSheet = false
    @State private var showingCompletionSheet = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Title Section
                    Text(activity.title)
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Completion Count Section
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color("BucketGold"))
                        Text("Completed \(activity.completionCount) time\(activity.completionCount == 1 ? "" : "s")")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    // Description Section
                    if let description = activity.description {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(description)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    
                    // Links Section
                    if activity.hasLinks {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Links")
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 4)
                            
                            if let websiteURL = activity.websiteURL {
                                LinkRow(icon: "globe", title: "Website", url: websiteURL)
                            }
                            if let instagramURL = activity.instagramURL {
                                LinkRow(icon: "camera", title: "Instagram", url: instagramURL)
                            }
                            if let beliURL = activity.beliURL {
                                LinkRow(icon: "link", title: "Beli", url: beliURL)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    
                    // Address Section
                    if let address = activity.address {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Location")
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(address)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    
                    // Notes Section
                    if !activity.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Activity History")
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(activity.notes.sorted { $0.date > $1.date }) { note in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.secondary)
                                        Text(note.date.formatted(date: .abbreviated, time: .shortened))
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    if !note.content.isEmpty {
                                        Text(note.content)
                                            .font(.body)
                                            .padding(.top, 4)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    } else {
                                        Text("Completed")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .padding(.top, 2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
                .padding(.bottom, 80)
            }
            
            // Sticky "I did this!" button
            VStack {
                Button(action: { showingCompletionSheet = true }) {
                    HStack {
                        Image(systemName: "checkmark.circle")
                        Text("I did this!")
                    }
                    .font(.headline)
                    .foregroundColor(Color("BucketGold"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("BucketGold").opacity(0.15))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .background(Color(.systemBackground))
            .shadow(color: .black.opacity(0.05), radius: 8, y: -4)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingEditSheet = true
                }) {
                    Text("Edit")
                        .foregroundColor(Color("BucketGold"))
                        .frame(minWidth: 44, minHeight: 44)
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            ActivityFormView(mode: .edit(activity))
        }
        .sheet(isPresented: $showingCompletionSheet) {
            CompletionView(activity: activity)
        }
    }
} 