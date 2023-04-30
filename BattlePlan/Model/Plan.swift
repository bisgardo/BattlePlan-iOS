import Foundation

struct Plan {
    var items: [Item]
    var deadline: Date
    
    var itemDeadlines: [Date] {
        print("computing!")
        var lastDeadline = deadline
        var res = items.reversed().map {
            lastDeadline -= TimeInterval($0.durationMinutes * 60)
            return lastDeadline
        }
        res.reverse()
        return res
    }
}

private let minute: TimeInterval = 60.0

extension Plan {
    static var sampleData = Plan(items: [
        Item(title: "Wake up", durationMinutes: 7),
        Item(title: "Shower", durationMinutes: 13),
        Item(title: "Find clothes", durationMinutes: 5),
        Item(title: "Get dressed", durationMinutes: 2),
        Item(title: "Get to train", durationMinutes: 3),
    ], deadline: Date.now)
}
