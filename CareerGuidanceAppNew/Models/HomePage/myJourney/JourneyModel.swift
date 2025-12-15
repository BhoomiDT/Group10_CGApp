import Foundation

struct JourneyStats {
    let days: String
    let quizzes: String
    let quests: String
}

struct JourneyModel {
    // These are the temporary values you requested
    static let sampleData = JourneyStats(
        days: "17",
        quizzes: "5",
        quests: "3"
    )
}
