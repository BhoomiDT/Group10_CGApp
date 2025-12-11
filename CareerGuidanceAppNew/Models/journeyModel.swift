//
//  journeyModel.swift
//  CareerGuidanceAppNew
//

import Foundation
import UIKit

struct JourneyItem {
    let iconName: String
    let iconColor: UIColor
    let iconBackgroundColor: UIColor
    let title: String
    let subtitle: String
}

struct JourneySection {
    let title: String
    let items: [JourneyItem]
}

enum JourneyData {

    static let milestones: [JourneySection] = [

        JourneySection(
            title: "December",
            items: [
                JourneyItem(
                    iconName: "paperplane.fill",
                    iconColor: UIColor(hex: "#1950A2") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#E0ECFC") ?? .clear,
                    title: "HTML & CSS Basics",
                    subtitle: "Structure and style the web"
                ),

                JourneyItem(
                    iconName: "target",
                    iconColor: UIColor(hex: "#D4A056") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#FAF3E7") ?? .clear,
                    title: "3 Goals Achieved!",
                    subtitle: "Consistency in goal completion"
                ),

                JourneyItem(
                    iconName: "flag.2.crossed",
                    iconColor: UIColor(hex: "#D53A6A") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#FFD4DF") ?? .clear,
                    title: "2 Quests Completed",
                    subtitle: "Consistency in goal completion"
                )
            ]
        ),

        JourneySection(
            title: "November",
            items: [
                JourneyItem(
                    iconName: "chevron.left.slash.chevron.right",
                    iconColor: UIColor(hex: "#A856F7") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#F6EFFE") ?? .clear,
                    title: "HTML & CSS Basics",
                    subtitle: "Structure and style the web"
                ),

                JourneyItem(
                    iconName: "flame.fill",
                    iconColor: UIColor(hex: "#E8771A") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#FFE7D4") ?? .clear,
                    title: "First 30-Day Streak Achieved",
                    subtitle: "Uninterrupted learning for a month"
                ),

                JourneyItem(
                    iconName: "checkmark.seal.fill",
                    iconColor: UIColor(hex: "#3E9862") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#D8FDEB") ?? .clear,
                    title: "Completed Core JavaScript",
                    subtitle: "Part of Web Dev Roadmap"
                )
            ]
        ),
        JourneySection(
            title: "October",
            items: [
                JourneyItem(
                    iconName: "laptopcomputer",
                    iconColor: UIColor(hex: "#0A84FF") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#E5F1FF") ?? .clear,
                    title: "Started Frontend Journey",
                    subtitle: "First step into development world"
                ),

                JourneyItem(
                    iconName: "book.fill",
                    iconColor: UIColor(hex: "#C46A12") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#FFEBD8") ?? .clear,
                    title: "Completed Basics of Programming",
                    subtitle: "Understanding logic & syntax"
                ),

                JourneyItem(
                    iconName: "brain.head.profile",
                    iconColor: UIColor(hex: "#B83F77") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#FFE3F0") ?? .clear,
                    title: "Built Strong Learning Habit",
                    subtitle: "Daily learning without distractions"
                )
            ]
        ),
        JourneySection(
            title: "September",
            items: [
                JourneyItem(
                    iconName: "sparkles",
                    iconColor: UIColor(hex: "#9C47D4") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#F3E6FF") ?? .clear,
                    title: "Kickstarted Self-Improvement",
                    subtitle: "Mindset shift toward growth"
                ),

                JourneyItem(
                    iconName: "calendar",
                    iconColor: UIColor(hex: "#D49B33") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#FFF1D9") ?? .clear,
                    title: "Routine & Discipline",
                    subtitle: "Building daily study schedule"
                ),

                JourneyItem(
                    iconName: "person.3.fill",
                    iconColor: UIColor(hex: "#207355") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#CDF7E6") ?? .clear,
                    title: "Joined Developer Community",
                    subtitle: "First exposure to tech ecosystem"
                )
            ]
        )
    ]

    static let skills: [JourneySection] = [

        JourneySection(
            title: "Mastered Capabilities",
            items: [

                JourneyItem(
                    iconName: "globe",
                    iconColor: UIColor(hex: "#0088FF") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#C9E7F4") ?? .clear,
                    title: "React",
                    subtitle: "Web Development Roadmap"
                ),

                JourneyItem(
                    iconName: "swift",
                    iconColor: UIColor(hex: "#E8771A") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#FEEEE0") ?? .clear,
                    title: "Swift Data",
                    subtitle: "Basics mastered"
                ),

                JourneyItem(
                    iconName: "leaf",
                    iconColor: UIColor(hex: "#3E9862") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#D8FDEB") ?? .clear,
                    title: "MongoDB",
                    subtitle: "Now proficient in basic data analysis"
                )
            ]
        ),

        JourneySection(
            title: "Data Analytics",
            items: [

                JourneyItem(
                    iconName: "curlybraces",
                    iconColor: UIColor(hex: "#1950A2") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#E0ECFC") ?? .clear,
                    title: "Tailwind CSS",
                    subtitle: "Easier way to write CSS"
                ),

                JourneyItem(
                    iconName: "chart.bar.fill",
                    iconColor: UIColor(hex: "#FBBF24") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#FEF3C7") ?? .clear,
                    title: "Basic Data Visualisation",
                    subtitle: "Foundational charts and insights"
                ),

                JourneyItem(
                    iconName: "tablecells",
                    iconColor: UIColor(hex: "#A856F7") ?? .black,
                    iconBackgroundColor: UIColor(hex: "#F3E9FF") ?? .clear,
                    title: "SQL Fundamentals",
                    subtitle: "In progress"
                )
            ]
        )
    ]
}
