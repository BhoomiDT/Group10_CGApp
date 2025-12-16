import Foundation

class AnswerStorage {
    static let shared = AnswerStorage()
    
    // Structure: [SectionIndex : [QuestionIndex : OptionIndex]]
    private var answers: [Int: [Int: Int]] = [:]

    func save(section: Int, question: Int, optionIndex: Int) {
        if answers[section] == nil {
            answers[section] = [:]
        }
        answers[section]?[question] = optionIndex
    }

    func getSavedOption(section: Int, question: Int) -> Int? {
        return answers[section]?[question]
    }
    
    // Helper to get all results for a section
    func getResultsForSection(_ sectionIndex: Int) -> [Int: Int] {
        return answers[sectionIndex] ?? [:]
    }
}
