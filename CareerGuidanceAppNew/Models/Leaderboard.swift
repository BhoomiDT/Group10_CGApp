//
//  Leaderboard.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 28/11/25.
//
// Data Structure
struct LeaderboardEntry {
    let rank: Int
    let name: String
    let xp: Int
    let imageName: String?
}

// Dummy Data (Ranks 1-10, sorted by XP)
let dailyLeaderboard: [LeaderboardEntry] = [
    // Ranks 1-3 (for Top 3 section)
    LeaderboardEntry(rank: 1, name: "Jessica", xp: 540, imageName: "Leaderboard1"),
    LeaderboardEntry(rank: 2, name: "Walter", xp: 500, imageName: "Leaderboard2"),
    LeaderboardEntry(rank: 3, name: "Tyrion", xp: 480, imageName: "Leaderboard3"),
    // Ranks 4-10 (for Table View list)
    LeaderboardEntry(rank: 4, name: "Rachel", xp: 460, imageName: nil),
    LeaderboardEntry(rank: 5, name: "Joey", xp: 450, imageName: nil),
    LeaderboardEntry(rank: 6, name: "Chandler", xp: 440, imageName: nil),
    LeaderboardEntry(rank: 7, name: "Ross", xp: 420, imageName: nil),
    LeaderboardEntry(rank: 8, name: "Phoebe", xp: 400, imageName: nil),
    LeaderboardEntry(rank: 9, name: "Monica", xp: 390, imageName: nil),
    LeaderboardEntry(rank: 10, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 11, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 12, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 13, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 14, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 15, name: "John", xp: 360, imageName: nil),
    // ... more data
]

let weeklyLeaderboard: [LeaderboardEntry] = [    // Ranks 1-3 (for Top 3 section)
    LeaderboardEntry(rank: 1, name: "Jessica", xp: 540, imageName: "Leaderboard1"),
    LeaderboardEntry(rank: 2, name: "Walter", xp: 500, imageName: "Leaderboard2"),
    LeaderboardEntry(rank: 3, name: "Tyrion", xp: 480, imageName: "Leaderboard3"),
    // Ranks 4-10 (for Table View list)
    LeaderboardEntry(rank: 4, name: "Rachel", xp: 470, imageName: nil),
    LeaderboardEntry(rank: 5, name: "Joey", xp: 460, imageName: nil),
    LeaderboardEntry(rank: 6, name: "Chandler", xp: 450, imageName: nil),
    LeaderboardEntry(rank: 7, name: "Ross", xp: 420, imageName: nil),
    LeaderboardEntry(rank: 8, name: "Phoebe", xp: 400, imageName: nil),
    LeaderboardEntry(rank: 9, name: "Monica", xp: 390, imageName: nil),
    LeaderboardEntry(rank: 10, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 11, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 12, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 13, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 14, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 15, name: "John", xp: 360, imageName: nil),
    // ... more data
]

let monthlyLeaderboard: [LeaderboardEntry] = [    // Ranks 1-3 (for Top 3 section)
    LeaderboardEntry(rank: 1, name: "Jessica", xp: 540, imageName: "Leaderboard1"),
    LeaderboardEntry(rank: 2, name: "Walter", xp: 500, imageName: "Leaderboard2"),
    LeaderboardEntry(rank: 3, name: "Tyrion", xp: 480, imageName: "Leaderboard3"),
    // Ranks 4-10 (for Table View list)
    LeaderboardEntry(rank: 4, name: "Rachel", xp: 480, imageName: nil),
    LeaderboardEntry(rank: 5, name: "Joey", xp: 475, imageName: nil),
    LeaderboardEntry(rank: 6, name: "Chandler", xp: 460, imageName: nil),
    LeaderboardEntry(rank: 7, name: "Ross", xp: 420, imageName: nil),
    LeaderboardEntry(rank: 8, name: "Phoebe", xp: 400, imageName: nil),
    LeaderboardEntry(rank: 9, name: "Monica", xp: 390, imageName: nil),
    LeaderboardEntry(rank: 10, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 11, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 12, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 13, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 14, name: "John", xp: 360, imageName: nil),
    LeaderboardEntry(rank: 15, name: "John", xp: 360, imageName: nil),
    // ... more data
]


