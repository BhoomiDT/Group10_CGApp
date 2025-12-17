//
//  Quiz.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//

import Foundation

enum LessonStatus: String {
    case startTest = "Start Test"
    case seeResults = "See Results"
}

struct Lesson {
    let id: String
    let name: String
    let dueDate: String
    let status: LessonStatus
}

struct Module {
    let title: String
    let lessons: [Lesson]
}

struct Roadmap {
    let title: String
    let description: String
    let imageName: String
    let modules: [Module]
}


// Describes a quiz for a lesson (NO user state here)
struct Quiz {
    let lessonId: String          // Links quiz to Lesson.id
    let lessonName: String
    let durationMinutes: Int
    let passingPercent: Int
    let questions: [QuizQuestion]
}

// Describes a single question (immutable)
struct QuizQuestion {
    let question: String
    let options: [String]
    let correctIndex: Int
}

// MARK: - Quiz Session (USER STATE)

// Tracks a user's attempt for a specific lesson quiz
struct QuizSession {
    let domainTitle: String       // Roadmap.title
    let moduleTitle: String       // Module.title
    let lessonId: String          // Lesson.id
    let quiz: Quiz

    // Index = question index, Value = selected option index
    var selectedOptionIndices: [Int?]
}

// MARK: - Quiz Factory (STATIC DATA SOURCE)

struct TestFactory {

    static func makeQuiz(
        lessonId: String,
        lessonName: String
    ) -> Quiz {

        switch lessonName {

        case "Data Cleaning Basics":
            return Quiz(
                lessonId: lessonId,
                lessonName: lessonName,
                durationMinutes: 30,
                passingPercent: 70,
                questions: [
                    QuizQuestion(
                        question: "Which of the following is NOT a visual design principle?",
                        options: [
                            "Contrast",
                            "Repetition",
                            "Alignment",
                            "Compilation"
                        ],
                        correctIndex: 3
                    ),
                    QuizQuestion(
                        question: "Which principle creates hierarchy?",
                        options: [
                            "Balance",
                            "Contrast",
                            "Unity",
                            "Flow"
                        ],
                        correctIndex: 1
                    )
                ]
            )

        case "Color Theory & Typography":
            return Quiz(
                lessonId: lessonId,
                lessonName: lessonName,
                durationMinutes: 25,
                passingPercent: 70,
                questions: [
                    QuizQuestion(
                        question: "Which color mode is used for print?",
                        options: [
                            "RGB",
                            "CMYK",
                            "HSB",
                            "Pantone"
                        ],
                        correctIndex: 1
                    )
                ]
            )

        default:
            // Fallback quiz
            return Quiz(
                lessonId: lessonId,
                lessonName: lessonName,
                durationMinutes: 20,
                passingPercent: 70,
                questions: [
                    QuizQuestion(
                        question: "Placeholder question?",
                        options: ["A", "B", "C", "D"],
                        correctIndex: 0
                    )
                ]
            )
        }
    }
}


let allRoadmaps: [Roadmap] = [

    // MARK: - Data Analytics
    Roadmap(
        title: "Data Analytics",
        description: "Learn to collect, process, and analyze data to generate insights and support business decision-making.",
        imageName: "data-analytics-role",
        modules: [

            Module(
                title: "Module 1: Foundations of Data",
                lessons: [
                    Lesson(
                        id: "data_understanding_data_types",
                        name: "Understanding Data Types",
                        dueDate: "Dec 18",
                        status: .seeResults
                    ),
                    Lesson(
                        id: "data_cleaning_basics",
                        name: "Data Cleaning Basics",
                        dueDate: "Dec 18",
                        status: .startTest
                    ),
                    Lesson(
                        id: "data_eda",
                        name: "Exploratory Data Analysis (EDA)",
                        dueDate: "Dec 19",
                        status: .startTest
                    )
                ]
            ),

            Module(
                title: "Module 2: Analytics Tools",
                lessons: [
                    Lesson(
                        id: "excel_analysis",
                        name: "Excel for Analysis",
                        dueDate: "Dec 22",
                        status: .startTest
                    ),
                    Lesson(
                        id: "sql_queries_joins",
                        name: "SQL Queries & Joins",
                        dueDate: "Dec 22",
                        status: .startTest
                    ),
                    Lesson(
                        id: "python_analytics",
                        name: "Python for Analytics",
                        dueDate: "Dec 22",
                        status: .startTest
                    )
                ]
            ),

            Module(
                title: "Module 3: Visualization & Insights",
                lessons: [
                    Lesson(
                        id: "tableau_dashboards",
                        name: "Dashboards with Tableau",
                        dueDate: "Dec 28",
                        status: .startTest
                    ),
                    Lesson(
                        id: "powerbi_essentials",
                        name: "Power BI Essentials",
                        dueDate: "Dec 28",
                        status: .startTest
                    ),
                    Lesson(
                        id: "presenting_insights",
                        name: "Presenting Data Insights",
                        dueDate: "Dec 29",
                        status: .startTest
                    )
                ]
            )
        ]
    ),

    // MARK: - AI & Machine Learning
    Roadmap(
        title: "AI & Machine Learning",
        description: "Build intelligent systems that learn from data and make accurate predictions or decisions.",
        imageName: "aiml-role",
        modules: [

            Module(
                title: "Module 1: ML Fundamentals",
                lessons: [
                    Lesson(
                        id: "python_ml",
                        name: "Python for ML",
                        dueDate: "Dec 15",
                        status: .seeResults
                    ),
                    Lesson(
                        id: "statistics_ml",
                        name: "Statistics for ML",
                        dueDate: "Dec 16",
                        status: .startTest
                    ),
                    Lesson(
                        id: "linear_regression",
                        name: "Linear Regression",
                        dueDate: "Dec 16",
                        status: .startTest
                    )
                ]
            ),

            Module(
                title: "Module 2: Core ML Algorithms",
                lessons: [
                    Lesson(
                        id: "classification_algorithms",
                        name: "Classification Algorithms",
                        dueDate: "Dec 22",
                        status: .startTest
                    ),
                    Lesson(
                        id: "kmeans_clustering",
                        name: "Clustering & K-Means",
                        dueDate: "Dec 22",
                        status: .startTest
                    ),
                    Lesson(
                        id: "decision_trees",
                        name: "Decision Trees & Random Forests",
                        dueDate: "Dec 22",
                        status: .startTest
                    )
                ]
            ),

            Module(
                title: "Module 3: Neural Networks",
                lessons: [
                    Lesson(
                        id: "neural_networks_intro",
                        name: "Introduction to Neural Nets",
                        dueDate: "Dec 29",
                        status: .startTest
                    ),
                    Lesson(
                        id: "tensorflow_models",
                        name: "Building Models in TensorFlow",
                        dueDate: "Dec 29",
                        status: .startTest
                    ),
                    Lesson(
                        id: "model_tuning",
                        name: "Model Tuning & Evaluation",
                        dueDate: "Dec 29",
                        status: .startTest
                    )
                ]
            )
        ]
    ),

    // MARK: - App Development
    Roadmap(
        title: "App Development",
        description: "Learn to build modern Android and iOS applications with clean UI and seamless performance.",
        imageName: "appdev-role 1",
        modules: [

            Module(
                title: "Module 1: Mobile Foundations",
                lessons: [
                    Lesson(
                        id: "kotlin_basics",
                        name: "Kotlin Basics for Android",
                        dueDate: "Dec 17",
                        status: .seeResults
                    ),
                    Lesson(
                        id: "swiftui_essentials",
                        name: "Swift & SwiftUI Essentials",
                        dueDate: "Dec 17",
                        status: .startTest
                    )
                ]
            ),

            Module(
                title: "Module 2: UI Development",
                lessons: [
                    Lesson(
                        id: "android_ui_xml",
                        name: "Android UI & XML Layouts",
                        dueDate: "Dec 24",
                        status: .startTest
                    ),
                    Lesson(
                        id: "swiftui_views",
                        name: "SwiftUI Views & Modifiers",
                        dueDate: "Dec 24",
                        status: .startTest
                    )
                ]
            ),

            Module(
                title: "Module 3: App Deployment",
                lessons: [
                    Lesson(
                        id: "play_store_publish",
                        name: "Publishing on Play Store",
                        dueDate: "Dec 30",
                        status: .startTest
                    ),
                    Lesson(
                        id: "app_store_requirements",
                        name: "App Store Requirements",
                        dueDate: "Dec 30",
                        status: .startTest
                    )
                ]
            )
        ]
    ),

    // MARK: - Cyber Security
    Roadmap(
        title: "Cyber Security",
        description: "Protect systems and networks from cyber threats using defensive and offensive security techniques.",
        imageName: "cyber-security-role",
        modules: [

            Module(
                title: "Module 1: Security Basics",
                lessons: [
                    Lesson(
                        id: "cyber_threats",
                        name: "Understanding Cyber Threats",
                        dueDate: "Dec 12",
                        status: .seeResults
                    ),
                    Lesson(
                        id: "encryption_hashing",
                        name: "Encryption & Hashing",
                        dueDate: "Dec 12",
                        status: .startTest
                    ),
                    Lesson(
                        id: "network_security",
                        name: "Network Security Essentials",
                        dueDate: "Dec 13",
                        status: .startTest
                    )
                ]
            ),

            Module(
                title: "Module 2: Ethical Hacking",
                lessons: [
                    Lesson(
                        id: "reconnaissance",
                        name: "Reconnaissance Techniques",
                        dueDate: "Dec 20",
                        status: .startTest
                    ),
                    Lesson(
                        id: "owasp_vulnerabilities",
                        name: "Web Vulnerabilities (OWASP)",
                        dueDate: "Dec 20",
                        status: .startTest
                    ),
                    Lesson(
                        id: "penetration_testing",
                        name: "Penetration Testing Basics",
                        dueDate: "Dec 20",
                        status: .startTest
                    )
                ]
            ),

            Module(
                title: "Module 3: Defensive Security",
                lessons: [
                    Lesson(
                        id: "firewalls_ids",
                        name: "Firewalls & IDS/IPS",
                        dueDate: "Dec 28",
                        status: .startTest
                    ),
                    Lesson(
                        id: "secure_coding",
                        name: "Secure Coding Practices",
                        dueDate: "Dec 28",
                        status: .startTest
                    ),
                    Lesson(
                        id: "incident_response",
                        name: "Incident Response",
                        dueDate: "Dec 28",
                        status: .startTest
                    )
                ]
            )
        ]
    )
]
