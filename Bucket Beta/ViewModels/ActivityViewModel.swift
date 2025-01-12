import Foundation

@MainActor
class ActivityViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var showingNewActivitySheet = false
    @Published var showingCompletionSheet = false
    @Published var selectedActivity: Activity?
    
    private let saveKey = "SavedActivities"
    
    init() {
        loadActivities()
    }
    
    func addActivity(_ activity: Activity) {
        activities.append(activity)
        saveActivities()
        showingNewActivitySheet = false
    }
    
    func updateActivity(_ activity: Activity) {
        if let index = activities.firstIndex(where: { $0.id == activity.id }) {
            activities[index] = activity
            saveActivities()
        }
    }
    
    func deleteActivity(_ activity: Activity) {
        activities.removeAll { $0.id == activity.id }
        saveActivities()
    }
    
    func deleteActivities(at offsets: IndexSet) {
        activities.remove(atOffsets: offsets)
        saveActivities()
    }
    
    func completeActivity(_ activity: Activity, note: String?) {
        if let index = activities.firstIndex(where: { $0.id == activity.id }) {
            var updatedActivity = activity
            updatedActivity.completionCount += 1
            updatedActivity.notes.append(ActivityNote(content: note ?? ""))
            activities[index] = updatedActivity
            saveActivities()
        }
    }
    
    func moveActivity(from source: IndexSet, to destination: Int) {
        activities.move(fromOffsets: source, toOffset: destination)
        saveActivities()
    }
    
    private func saveActivities() {
        if let encoded = try? JSONEncoder().encode(activities) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadActivities() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Activity].self, from: data) {
            activities = decoded
        }
    }
} 