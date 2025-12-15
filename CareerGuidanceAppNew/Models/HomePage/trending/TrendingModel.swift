import Foundation

struct TrendingItem {
    let title: String
    let description: String
    let imageName: String
}

struct TrendingModel {
    static let sampleData: [TrendingItem] = [
        TrendingItem(
            title: "AI & Machine Learning",
            description: "Teaching machines to learn and make smart decisions.",
            imageName: "MachineLearning"
        ),
        TrendingItem(
            title: "Web Development",
            description: "Building responsive websites and web applications.",
            imageName: "WebDev"
        ),
        TrendingItem(
            title: "Cyber Security",
            description: "Protecting systems and networks from digital attacks.",
            imageName: "CyberSecurity"
        )
    ]
}
