//
//  QuizViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 10/12/25.
//

import UIKit

class QuizViewController: UIViewController {
    var lesson: Lesson?
    var quiz: Quiz?

    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var QuestionTextLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var optionStack: UIStackView!
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var optionButton3: UIButton!
    @IBOutlet weak var optionButton4: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    private var selectedOptionIndices: [Int?] = []
    private var currentQuestionIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        nextButton.layer.cornerRadius = 20
        optionStack.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        optionButton1.tag = 0
        optionButton2.tag = 1
        optionButton3.tag = 2
        optionButton4.tag = 3
        guard let quiz = quiz else { return }
        
            selectedOptionIndices = Array(
                repeating: nil,
                count: quiz.questions.count
            )
        loadQuestion()
    }
    @IBAction func optionTapped(_ sender: UIButton) {
        print("Tapped index:", sender.tag)
        let selectedIndex = sender.tag
        selectedOptionIndices[currentQuestionIndex] = selectedIndex
        updateSelectionUI(selectedIndex: selectedIndex)
        
    }
    private func loadQuestion() {
        guard let quiz = quiz else { return }

        let question = quiz.questions[currentQuestionIndex]

        QuestionNumberLabel.text = "Question \(currentQuestionIndex + 1)"
        QuestionTextLabel.text = question.question

        optionButton1.setTitle(question.options[0], for: .normal)
        optionButton2.setTitle(question.options[1], for: .normal)
        optionButton3.setTitle(question.options[2], for: .normal)
        optionButton4.setTitle(question.options[3], for: .normal)
        
        if let selectedIndex = selectedOptionIndices[currentQuestionIndex] {
                updateSelectionUI(selectedIndex: selectedIndex)
            } else {
                resetOptionUI()
            }
        updateNextButtonTitle()
        updateProgressBar()
    }
    private func updateProgressBar() {
        guard let quiz = quiz else { return }

        let progress = Float(currentQuestionIndex + 1) / Float(quiz.questions.count)
        progressBar.setProgress(progress, animated: true)
    }
    private func updateNextButtonTitle() {
        guard let quiz = quiz else { return }

        if currentQuestionIndex == quiz.questions.count - 1 {
            nextButton.setTitle("Submit", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    private func isCurrentQuestionAnswered() -> Bool {
        return selectedOptionIndices[currentQuestionIndex] != nil
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let quiz = quiz else { return }
        print("Next Button tapped")
//        guard let selectedIndex = selectedOptionIndices[currentQuestionIndex] else { return }
//        selectedOptionIndices[currentQuestionIndex] = selectedIndex
        // Ensure user selected an option
        guard isCurrentQuestionAnswered() else {
            showAlert(
                title: "Select an option",
                message: "Please select an answer before continuing."
            )
            return
        }

        // LAST QUESTION → SUBMIT
        if currentQuestionIndex == quiz.questions.count - 1 {
            showSubmitConfirmation()
        } else {
            // Move to next question
            currentQuestionIndex += 1
            loadQuestion()
        }
    }
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }
    private func showSubmitConfirmation() {
        let alert = UIAlertController(
            title: "Submit Test?",
            message: "Your test is being submitted.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        alert.addAction(UIAlertAction(title: "Submit", style: .default) { _ in
            let result = self.generateTestResult()
            self.navigateToResults(result: result)
        })

        present(alert, animated: true)
    }
    private func updateSelectionUI(selectedIndex: Int) {
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4]
        let selectedColor = UIColor(hex: "#1FA5A1")

        for (index, button) in buttons.enumerated() {
            guard let button = button else { continue }
            if index == selectedIndex {
                button.layer.borderWidth = 2
                button.layer.borderColor = selectedColor.cgColor
                button.setTitleColor(selectedColor, for: .normal)
            } else {
                button.layer.borderWidth = 0
                button.layer.borderColor = UIColor.clear.cgColor
                button.setTitleColor(.label, for: .normal)
                button.backgroundColor = .systemGray6
            }
        }
    }

    private func resetOptionUI() {
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4]
        buttons.forEach {
            $0?.backgroundColor = .systemGray6
            $0?.layer.borderColor = UIColor.clear.cgColor
            $0?.layer.borderWidth = 0
            $0?.setTitleColor(.label, for: .normal)
        }
    }
    func calculateScore() -> Int {
        guard let quiz = quiz else { return 0 }

        var correct = 0
        for (index, question) in quiz.questions.enumerated() {
            if selectedOptionIndices[index] == question.correctIndex {
                correct += 1
            }
        }

        return Int(
            (Double(correct) / Double(quiz.questions.count)) * 100
        )
    }
    private func generateTestResult() -> TestResult {
        guard let quiz = quiz else {
            return TestResult(
                score: 0,
                strengths: [],
                improvements: [],
                lessonName: ""
            )
        }

        let finalScore: Int

        if lesson?.status == .seeResults {
            finalScore = 80
        } else {
            finalScore = calculateScore()
        }

        let strengths: [StrengthItem] = [
            StrengthItem(title: "User Interface Design"),
            StrengthItem(title: "Prototyping"),
            StrengthItem(title: "Basic Compliance")
        ]

        let improvements: [ImprovementItem] = [
            ImprovementItem(title: "User Research"),
            ImprovementItem(title: "Accessibility Standards"),
            ImprovementItem(title: "Usability")
        ]

        return TestResult(
            score: finalScore,
            strengths: strengths,
            improvements: improvements,
            lessonName: quiz.lessonName
        )
    }
    private func navigateToResults(result: TestResult) {
        let storyboard = UIStoryboard(name: "Roadmaps", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "TestResultsVC"
        ) as! TestResultsViewController

        vc.lesson = self.lesson
        vc.testResult = result

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
