import UIKit
struct RIASECEntry {
    let label: String       // e.g., "Realistic"
    let color: UIColor      // The color for the progress bar
    let score: Float        // Progress value from 0.0 to 1.0
    let type: String        // The initial, e.g., "R"
}

let riasecData: [RIASECEntry] = [
    RIASECEntry(label: "Realistic", color: .riasecRealistic, score: 0.85, type: "R"),
    RIASECEntry(label: "Investigative", color: .riasecInvestigative, score: 0.60, type: "I"),
    RIASECEntry(label: "Artistic", color: .riasecArtistic, score: 0.45, type: "A"),
    RIASECEntry(label: "Social", color: .riasecSocial, score: 0.92, type: "S"),
    RIASECEntry(label: "Enterprising", color: .riasecEnterprising, score: 0.70, type: "E"),
    RIASECEntry(label: "Conventional", color: .riasecConventional, score: 0.30, type: "C")
]

let interests: [String] = ["Strong analytical and problem solving skills", "Interest in technology and innovation", "Alignment with logical and systematic thinking"]
