//
//  BadgeData.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 08/12/25.
//
import UIKit // Needed for UIColor

// 1. Structure for a single Badge item
struct Badge {
    let id: Int
    let title: String          // e.g., "Active Starter"
    let subtitle: String?      // Subtitle used in the modal view
    let iconName: String       // SF Symbol name, e.g., "crown.fill"
    let color: UIColor?         // Color for the background circle/hexagon
    let isUnlocked: Bool       // Status (affects appearance)
}

// 2. Structure for a Section (e.g., "Featured")
struct BadgeSection {
    let title: String
    let badges: [Badge]
}

let customTeal = UIColor(hex: "#f2f2f7")

// Array containing all sections and their badge data
let allBadgeSections: [BadgeSection] = [
    
    // --- Featured Section (Section 0) ---
    BadgeSection(title: "Featured", badges: [
        
        Badge(id: 1, title: "Active Starter", subtitle: "You conquered your first badge!",
              iconName: "crown.fill", color: UIColor(hex: "#1fa5a1"), isUnlocked: true),
        
        Badge(id: 2, title: "High Achiever", subtitle: "Completed 5 goals in one day.",
              iconName: "airplane.up.right", color: UIColor(hex: "#1fa5a1"), isUnlocked: true),
        
        Badge(id: 3, title: "Eager Learner", subtitle: "Read 10 learning articles.",
              iconName: "book.fill", color: UIColor(hex: "#1fa5a1"), isUnlocked: true),
        
        Badge(id: 4, title: "Serious Learner", subtitle: "Completed a full learning module.",
              iconName: "wrench.and.screwdriver.fill", color: .systemGray, isUnlocked: false),
        
        Badge(id: 5, title: "Confident Reader", subtitle: "Passed 5 knowledge checks.",
              iconName: "flag.fill", color: .systemGray, isUnlocked: false),
        
        Badge(id: 6, title: "Error Police", subtitle: "Found and fixed 3 bugs.",
              iconName: "shield.lefthalf.fill", color: .systemGray, isUnlocked: false),
    ]),
    
    // --- Weekly Achievement Section (Section 1) ---
    BadgeSection(title: "Weekly Achievement", badges: [
        
        Badge(id: 7, title: "Hot Week", subtitle: "Highest XP gain this week!",
              iconName: "flame.fill", color: .systemOrange, isUnlocked: true),
        
        Badge(id: 8, title: "Super Week", subtitle: "Maxed out all daily streaks.",
              iconName: "fireworks", color: .systemTeal, isUnlocked: true),
        
        Badge(id: 9, title: "Cold Week", subtitle: "Stayed consistent despite setbacks.",
              iconName: "cloud.snow.fill", color: .systemBlue, isUnlocked: true),
        
        Badge(id: 10, title: "Joy Week", subtitle: "Helped 5 other users.",
              iconName: "face.smiling.fill", color: .systemGray, isUnlocked: false),
    ])
]

