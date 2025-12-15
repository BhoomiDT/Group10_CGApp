//
//  Answers.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//

import Foundation

struct QuestionAnswer {
    let questionText: String
    let isCorrect: Bool // True for checkmark, False for X mark
}


let userAnswersData: [QuestionAnswer] = [
    QuestionAnswer(questionText: "Question 1", isCorrect: true),
    QuestionAnswer(questionText: "Question 2", isCorrect: true),
    QuestionAnswer(questionText: "Question 3", isCorrect: false),
    QuestionAnswer(questionText: "Question 4", isCorrect: true),
    QuestionAnswer(questionText: "Question 5", isCorrect: true),
    QuestionAnswer(questionText: "Question 6", isCorrect: false),
    QuestionAnswer(questionText: "Question 7", isCorrect: true),
    QuestionAnswer(questionText: "Question 8", isCorrect: true),
    QuestionAnswer(questionText: "Question 9", isCorrect: true),
    QuestionAnswer(questionText: "Question 10", isCorrect: false)
]
