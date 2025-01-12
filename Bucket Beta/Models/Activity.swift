import Foundation

struct Activity: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var description: String?
    var websiteURL: String?
    var instagramURL: String?
    var address: String?
    var beliURL: String?
    var completionCount: Int
    var notes: [ActivityNote]
    
    init(id: UUID = UUID(), 
         title: String, 
         description: String? = nil, 
         websiteURL: String? = nil,
         instagramURL: String? = nil, 
         address: String? = nil, 
         beliURL: String? = nil,
         completionCount: Int = 0,
         notes: [ActivityNote] = []) {
        self.id = id
        self.title = title
        self.description = description
        self.websiteURL = websiteURL
        self.instagramURL = instagramURL
        self.address = address
        self.beliURL = beliURL
        self.completionCount = completionCount
        self.notes = notes
    }
}

struct ActivityNote: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let content: String
    
    init(id: UUID = UUID(), date: Date = Date(), content: String) {
        self.id = id
        self.date = date
        self.content = content
    }
} 