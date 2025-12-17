//
//  staticRoadmap.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 02/12/25.
//
import UIKit   // Needed for UIColor

// MARK: - Milestone Model
struct Milestone {
    let title: String
    let subtitle: String
    let iconName: String          // SF Symbol name
    let iconColor: UIColor?       // Icon tint color
    let iconBackgroundColor: UIColor?
}

// MARK: - Static Roadmap Model
struct StaticRoadmap {
    let title: String
    let description: String
    let imageName: String?
    let modules: [Module]?        // Kept optional so nothing breaks
    let milestones: [Milestone]
}

// MARK: - Static Roadmap Data
let staticRoadmaps: [StaticRoadmap] = [

    StaticRoadmap(
        title: "Web Development",
        description: "Master core web languages, specialize in front- or back-end, then learn architecture and deployment.",
        imageName: nil,
        modules: nil,
        milestones: [

            Milestone(
                title: "HTML & CSS Basics",
                subtitle: "Structure and style the web",
                iconName: "building.columns",
                iconColor: UIColor(hex: "#1950A2"),
                iconBackgroundColor: UIColor(hex: "#E0ECFC")
            ),

            Milestone(
                title: "JavaScript Essentials",
                subtitle: "Add logic and interactivity",
                iconName: "shippingbox.fill",
                iconColor: UIColor(hex: "#D4A056"),
                iconBackgroundColor: UIColor(hex: "#FAF3E7")
            ),

            Milestone(
                title: "Frontend Frameworks",
                subtitle: "Build dynamic user interfaces",
                iconName: "star",
                iconColor: UIColor(hex: "#D53A6A"),
                iconBackgroundColor: UIColor(hex: "#FFD4DF")
            ),

            Milestone(
                title: "Backend Development",
                subtitle: "Power your apps with servers",
                iconName: "xserve.raid",
                iconColor: UIColor(hex: "#A856F7"),
                iconBackgroundColor: UIColor(hex: "#F6EFFE")
            ),

            Milestone(
                title: "APIs & Databases",
                subtitle: "Connect data and services",
                iconName: "cloud",
                iconColor: UIColor(hex: "#E8771A"),
                iconBackgroundColor: UIColor(hex: "#FFE7D4")
            )
        ]
    )
]
