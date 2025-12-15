import Foundation

struct ChatMessage {
    let text: String
    let isUser: Bool 
}

struct AssistantBrain {
    
    static func getAnswer(for question: String) -> String {
        let text = question.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // GREETINGS
        if text.contains("hello") || text.contains("hi") || text.contains("hey") {
            return "Hello there! ready to continue your learning journey?"
        }
        
        if text.contains("how are you") {
            return "I am functioning at 100% efficiency! How are you doing?"
        }
        
        if text.contains("bye") || text.contains("goodbye") {
            return "See you later! Don't forget to keep your streak alive."
        }
        
        // APP FEATURES
        if text.contains("roadmap") {
            return "Your Roadmaps show your learning path. You can find them on the Home screen under the 'My Roadmaps' section."
        }
        
        if text.contains("xp") || text.contains("experience") {
            return "XP (Experience Points) measures your progress. You earn 10 XP for every lesson and 50 XP for completing a milestone."
        }
        
        if text.contains("streak") {
            return "Your streak counts how many consecutive days you've learned. You currently have a 7-day streak!"
        }
        
        if text.contains("leaderboard") || text.contains("rank") {
            return "The Leaderboard shows top learners. Complete more quizzes to climb the ranks!"
        }
        
        if text.contains("badge") {
            return "Badges are earned by mastering specific topics. Check your Profile to see your collection."
        }
        
        if text.contains("profile") || text.contains("account") {
            return "You can edit your details and view your stats by tapping the icon in the top right corner."
        }
        
        // TECHNICAL CONCEPTS (SWIFT)
        if text.contains("swift") {
            return "Swift is a powerful, intuitive programming language created by Apple for building apps."
        }
        
        if text.contains("variable") || text.contains("var") || text.contains("let") {
            return "In Swift, use 'var' for values that change and 'let' for constants that stay the same."
        }
        
        if text.contains("array") {
            return "An Array is an ordered collection of values. Example: let numbers = [1, 2, 3]."
        }
        
        if text.contains("loop") || text.contains("for") {
            return "Loops allow you to repeat code. The 'for-in' loop is the most common way to iterate over arrays."
        }
        
        if text.contains("uikit") {
            return "UIKit is the framework used to build the user interface of iOS applications, containing buttons, labels, and tables."
        }
        
        if text.contains("bug") || text.contains("error") {
            return "Debugging is part of the process! Check your console for error messages and review your constraints."
        }
        
        // MOTIVATION
        if text.contains("tired") || text.contains("hard") || text.contains("stuck") {
            return "Don't give up! Learning to code is a marathon, not a sprint. Take a small break and come back."
        }
        
        if text.contains("joke") {
            return "Why do programmers prefer dark mode? Because light attracts bugs!"
        }
        
        // DEFAULT FALLBACK
        return "I'm not sure about that one yet. Try asking about 'Roadmaps', 'Streaks', or specific Swift topics like 'Variables'."
    }
}
