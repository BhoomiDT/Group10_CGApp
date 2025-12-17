//
//  QuestionResult.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 15/12/25.
//

import Foundation

// 1. Structure to hold the user's specific answer and status for one question.
// This is the model that directly feeds the rows of your "Your Answers" table.
struct QuestionResult {
    
    let questionText: String
    
    // The actual index the user selected (e.g., 0, 1, 2, or 3)
    let userSelectedIndex: Int?
    
    // The correct index from the original QuizQuestion
    let correctIndex: Int
    
    // Derived property used to determine the checkmark/Xmark status
    var isCorrect: Bool {
        // If userSelectedIndex is nil (unanswered), it is incorrect.
        guard let selected = userSelectedIndex else {
            return false
        }
        return selected == correctIndex
    }
}


// 2. Structure to hold the overall result of a single quiz taken by the user.
struct QuizResult {
    
    let lessonName: String
    let quizDate: Date
    
    // The main data source for the "Your Answers" screen (the list of results)
    let results: [QuestionResult]
    
    // Derived properties for calculating score/status
    var totalQuestions: Int {
        return results.count
    }
    
    var correctCount: Int {
        return results.filter { $0.isCorrect }.count
    }
    
    var scorePercentage: Int {
        guard totalQuestions > 0 else { return 0 }
        let percent = Double(correctCount) / Double(totalQuestions) * 100
        return Int(percent.rounded())
    }
    
    // You would typically reference the passingPercent from the TestFactory here
    // var isPass: Bool { ... }
}
