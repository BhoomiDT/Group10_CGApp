import Foundation

struct ProfileSection {
    let title: String?
    let options: [String]
    
    static let sampleData: [ProfileSection] = [
        ProfileSection(title: "Account", options: ["Personal Details", "Account Settings"]),
        ProfileSection(title: "Features", options: ["Notifications", "Reminders and Alerts"]),
        ProfileSection(title: "Privacy", options: ["App Permissions", "Data and Storage"]),
        ProfileSection(title: nil, options: ["Log Out"])
    ]
}

