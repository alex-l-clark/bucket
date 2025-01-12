import SwiftUI

struct NoteRow: View {
    let note: ActivityNote
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.content)
            Text(note.date.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
} 