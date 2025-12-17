//
//  onboarding.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 27/11/25.
//

import Foundation

struct Section {
    let symbolName: String
    let title: String
    let subtitle: String
    let questions: [Question]
}

struct Question {
    let qText: String
    let options: [String]
}

let psychometricAnswers: [String] = ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"]

class Questionnaire {
    let sections: [Section]

    init() {
        sections = [
            // MARK: - Section 0: Intro / Roadmap (The Walking Man)
            // Questions array is empty because this is just an introductory/start screen.
            Section(
                symbolName: "figure.walk", // SF Symbol for walking person
                title: "Your Personal Roadmap",
                subtitle: "Let's create a personalized career path tailored just for you.",
                questions: []
            ),
            
            // MARK: - Section 1: Technical Skills
            // Questions array is empty because this launches the Custom Tech Skills UI.
            Section(
                symbolName: "terminal.fill",
                title: "Technical Skills",
                subtitle: "Add your technical skills to get a personalized roadmap",
                questions: []
            ),
            
            // MARK: - Section 2: Practical & Analytical (Psychometric)
            Section(
                symbolName: "lightbulb.fill",
                title: "Practical & Analytical Thinking",
                subtitle: "Tell us about your problem-solving style and hands-on approach to tasks",
                questions: [
                    Question(
                        qText: "How comfortable are you with breaking down complex problems?",
                        options: psychometricAnswers
                    ),
                    Question(
                        qText: "How often do you work on logical puzzles or problem-solving tasks?",
                        options: psychometricAnswers
                    )
                ]
            ),
            
            // MARK: - Section 3: Creative (Psychometric)
            Section(
                symbolName: "paintpalette.fill",
                title: "Creative & Focused Interests",
                subtitle: "Share your creativity and communication interests to refine your roadmap",
                questions: [
                    Question(
                        qText: "How much do you enjoy creative work (design, content, UI, etc.)?",
                        options: psychometricAnswers
                    ),
                    Question(
                        qText: "How comfortable are you with presenting or explaining ideas?",
                        options: psychometricAnswers
                    )
                ]
            ),
            
            // MARK: - Section 4: Business (Psychometric)
            Section(
                symbolName: "briefcase.fill",
                title: "Business & Organizational Skills",
                subtitle: "Let us understand your leadership style and comfort with planning roles",
                questions: [
                    Question(
                        qText: "How interested are you in planning, coordination, or management roles?",
                        options: psychometricAnswers
                    ),
                    Question(
                        qText: "How comfortable are you leading a small team or group?",
                        options: psychometricAnswers
                    )
                ]
            )
        ]
    }
}

