import Foundation

struct UserProfile {
    let name: String
    let email: String
    let imageName: String // System icon name or asset name
    
    static let currentUser = UserProfile(
        name: "James Doe",
        email: "james.doe@gmail.com",
        imageName: "person.crop.circle.fill"
    )
}
