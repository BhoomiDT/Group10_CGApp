//
//  Leaderboard.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 28/11/25.
//

import Foundation

// Data Structure
struct LeaderboardEntry {
    let rank: Int
    let name: String
    let xp: Int
    let imageName: String?
}

// --- DAILY LEADERBOARD (Lower XP values, typical for one day) ---
let dailyLeaderboard: [LeaderboardEntry] = [
    // Ranks 1-3
    LeaderboardEntry(rank: 1, name: "Jessica", xp: 150, imageName: "Leaderboard1"),
    LeaderboardEntry(rank: 2, name: "Walter", xp: 135, imageName: "Leaderboard2"),
    LeaderboardEntry(rank: 3, name: "Tyrion", xp: 120, imageName: "Leaderboard3"),
    // Ranks 4-15
    LeaderboardEntry(rank: 4, name: "Sarah", xp: 110, imageName: nil),
    LeaderboardEntry(rank: 5, name: "Mike", xp: 105, imageName: nil),
    LeaderboardEntry(rank: 6, name: "Emily", xp: 95, imageName: nil),
    LeaderboardEntry(rank: 7, name: "David", xp: 90, imageName: nil),
    LeaderboardEntry(rank: 8, name: "Chris", xp: 85, imageName: nil),
    LeaderboardEntry(rank: 9, name: "Anna", xp: 80, imageName: nil),
    LeaderboardEntry(rank: 10, name: "Tom", xp: 75, imageName: nil),
    LeaderboardEntry(rank: 11, name: "Lisa", xp: 70, imageName: nil),
    LeaderboardEntry(rank: 12, name: "Mark", xp: 65, imageName: nil),
    LeaderboardEntry(rank: 13, name: "Paul", xp: 60, imageName: nil),
    LeaderboardEntry(rank: 14, name: "Kate", xp: 55, imageName: nil),
    LeaderboardEntry(rank: 15, name: "James", xp: 50, imageName: nil)
]

// --- WEEKLY LEADERBOARD (Medium XP values, accumulated over 7 days) ---
let weeklyLeaderboard: [LeaderboardEntry] = [
    // Ranks 1-3
    LeaderboardEntry(rank: 1, name: "Rachel", xp: 850, imageName: "Leaderboard1"),
    LeaderboardEntry(rank: 2, name: "Joey", xp: 820, imageName: "Leaderboard2"),
    LeaderboardEntry(rank: 3, name: "Chandler", xp: 790, imageName: "Leaderboard3"),
    // Ranks 4-15
    LeaderboardEntry(rank: 4, name: "Jessica", xp: 750, imageName: nil),
    LeaderboardEntry(rank: 5, name: "Walter", xp: 700, imageName: nil),
    LeaderboardEntry(rank: 6, name: "Ross", xp: 680, imageName: nil),
    LeaderboardEntry(rank: 7, name: "Phoebe", xp: 650, imageName: nil),
    LeaderboardEntry(rank: 8, name: "Monica", xp: 620, imageName: nil),
    LeaderboardEntry(rank: 9, name: "Tyrion", xp: 600, imageName: nil),
    LeaderboardEntry(rank: 10, name: "Steve", xp: 580, imageName: nil),
    LeaderboardEntry(rank: 11, name: "Tony", xp: 550, imageName: nil),
    LeaderboardEntry(rank: 12, name: "Bruce", xp: 530, imageName: nil),
    LeaderboardEntry(rank: 13, name: "Natasha", xp: 500, imageName: nil),
    LeaderboardEntry(rank: 14, name: "Clint", xp: 480, imageName: nil),
    LeaderboardEntry(rank: 15, name: "Thor", xp: 450, imageName: nil)
]

// --- MONTHLY LEADERBOARD (High XP values, accumulated over 30 days) ---
let monthlyLeaderboard: [LeaderboardEntry] = [
    // Ranks 1-3
    LeaderboardEntry(rank: 1, name: "Daenerys", xp: 3500, imageName: "Leaderboard1"),
    LeaderboardEntry(rank: 2, name: "Jon", xp: 3200, imageName: "Leaderboard2"),
    LeaderboardEntry(rank: 3, name: "Arya", xp: 3100, imageName: "Leaderboard3"),
    // Ranks 4-15
    LeaderboardEntry(rank: 4, name: "Sansa", xp: 2900, imageName: nil),
    LeaderboardEntry(rank: 5, name: "Bran", xp: 2800, imageName: nil),
    LeaderboardEntry(rank: 6, name: "Rachel", xp: 2600, imageName: nil),
    LeaderboardEntry(rank: 7, name: "Joey", xp: 2500, imageName: nil),
    LeaderboardEntry(rank: 8, name: "Chandler", xp: 2400, imageName: nil),
    LeaderboardEntry(rank: 9, name: "Jessica", xp: 2300, imageName: nil),
    LeaderboardEntry(rank: 10, name: "Walter", xp: 2200, imageName: nil),
    LeaderboardEntry(rank: 11, name: "Tyrion", xp: 2100, imageName: nil),
    LeaderboardEntry(rank: 12, name: "Jaime", xp: 2000, imageName: nil),
    LeaderboardEntry(rank: 13, name: "Cersei", xp: 1900, imageName: nil),
    LeaderboardEntry(rank: 14, name: "Brienne", xp: 1800, imageName: nil),
    LeaderboardEntry(rank: 15, name: "Samwell", xp: 1700, imageName: nil)
]
