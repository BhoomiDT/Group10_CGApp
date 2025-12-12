//
//  testResults.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 10/12/25.
//
//Model file

struct StrengthItem {
    let title: String
}

struct ImprovementItem {
    let title: String
}

struct TestResult {
    let score: Int
    let strengths: [StrengthItem]
    let improvements: [ImprovementItem]
    let lessonName: String
}

func makeTestResult(for lessonName: String) -> TestResult {
    return TestResult(
        score: 80, // static or computed later
        strengths: [
            StrengthItem(title: "User Interface Design"),
            StrengthItem(title: "Prototyping"),
            StrengthItem(title: "Basic Compliance")
        ],
        improvements: [
            ImprovementItem(title: "User Research"),
            ImprovementItem(title: "Accessibility Standards"),
            ImprovementItem(title: "Usability")
        ],
        lessonName: lessonName   // dynamic value passed by controller
    )
}
