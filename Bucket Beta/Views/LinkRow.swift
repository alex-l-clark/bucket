import SwiftUI

struct LinkRow: View {
    let icon: String
    let title: String
    let url: String
    
    var body: some View {
        if let url = URL(string: url) {
            Link(destination: url) {
                HStack {
                    Image(systemName: icon)
                    Text(title)
                    Spacer()
                    Image(systemName: "arrow.up.right")
                }
            }
            .foregroundColor(Color("BucketGold"))
        }
    }
} 