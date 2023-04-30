import Foundation

struct Item: Identifiable {
    var id = UUID()
    var title: String
    var durationMinutes: Int
    
    var durationText: String {
        if durationMinutes == 1 {
            return "1 minute"
        }
        return "\(durationMinutes) minutes"
    }
}
