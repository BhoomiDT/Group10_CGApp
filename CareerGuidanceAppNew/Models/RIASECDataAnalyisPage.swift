import UIKit
struct RIASECEntry {
    let label: String       // e.g., "Realistic"
    let color: UIColor      // The color for the progress bar
    let score: Float        // Progress value from 0.0 to 1.0
    let type: String        // The initial, e.g., "R"
}

let riasecData: [RIASECEntry] = [
    RIASECEntry(label: "Realistic", color: .riasecRealistic ?? .systemRed, score: 0.05, type: "R"),
    RIASECEntry(label: "Investigative", color: .riasecInvestigative ?? .systemOrange, score: 0.60, type: "I"),
    RIASECEntry(label: "Artistic", color: .riasecArtistic ?? .systemYellow, score: 0.78, type: "A"),
    RIASECEntry(label: "Social", color: .riasecSocial ?? .systemGreen, score: 0.86, type: "S"),
    RIASECEntry(label: "Enterprising", color: .riasecEnterprising ?? .systemBlue, score: 0.70, type: "E"),
    RIASECEntry(label: "Conventional", color: .riasecConventional ?? .systemPurple, score: 0.30, type: "C")
]

let interests: [String] = ["Strong analytical and problem solving skills", "Interest in technology and innovation", "Alignment with logical and systematic thinking"]
