import Foundation
import UIKit

struct RoadmapModel {
    let title: String
    let subtitle: String
    let percentage: Int
    let milestone: String
    
    var percentageFloat: CGFloat {
        return CGFloat(percentage) / 100.0
    }
    
    // Static Sample Data
    static let sampleData: [RoadmapModel] = [
        RoadmapModel(title: "Web Development", subtitle: "Personalised Roadmap", percentage: 90, milestone: "Learn Frameworks"),
        RoadmapModel(title: "iOS Development", subtitle: "Career Path", percentage: 45, milestone: "Master SwiftData"),
        RoadmapModel(title: "UI/UX Design", subtitle: "Skill Builder", percentage: 10, milestone: "Figma Basics"),
        RoadmapModel(title: "Backend Engineering", subtitle: "Advanced Track", percentage: 0, milestone: "System Design")
    ]
}
