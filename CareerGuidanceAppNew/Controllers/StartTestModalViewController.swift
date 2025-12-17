//
//  StartTestModalViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//

//
//  StartTestModalViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//

import UIKit

protocol StartTestModalDelegate: AnyObject {
    func didTapStartTest(quiz: Quiz)
}

class StartTestModalViewController: UIViewController {

    // MARK: - Outlets
    //buttons
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    // Close button (circle view + icon)
    @IBOutlet weak var closeButtonContainer: UIView!
    @IBOutlet weak var closeImageView: UIImageView!

    // Row 1 – Duration
    @IBOutlet weak var durationIconBackground: UIView!
    @IBOutlet weak var durationIcon: UIImageView!
    @IBOutlet weak var durationTitleLabel: UILabel!
    @IBOutlet weak var durationSubtitleLabel: UILabel!

    @IBOutlet weak var modalView: UIView!
    // Row 2 – Questions
    @IBOutlet weak var questionsIconBackground: UIView!
    @IBOutlet weak var questionsIcon: UIImageView!
    @IBOutlet weak var questionsTitleLabel: UILabel!
    @IBOutlet weak var questionsSubtitleLabel: UILabel!

    // Row 3 – Passing Score
    @IBOutlet weak var passingIconBackground: UIView!
    @IBOutlet weak var passingIcon: UIImageView!
    @IBOutlet weak var passingTitleLabel: UILabel!
    @IBOutlet weak var passingSubtitleLabel: UILabel!

    // Row 4 – Attempts
    @IBOutlet weak var attemptsIconBackground: UIView!
    @IBOutlet weak var attemptsIcon: UIImageView!
    @IBOutlet weak var attemptsTitleLabel: UILabel!
    @IBOutlet weak var attemptsSubtitleLabel: UILabel!

    // Info label
    @IBOutlet weak var infoLabel: UILabel!

    // MARK: - Data
    weak var delegate: StartTestModalDelegate?
    var lesson: Lesson!
    private var quiz: Quiz!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyling()
        loadQuiz()
        setupCloseButton()
    }

    // MARK: - Setup UI

    private func setupStyling() {

        // Close button
        closeButtonContainer.layer.cornerRadius = closeButtonContainer.frame.height / 2
        closeButtonContainer.backgroundColor = UIColor.systemGray5

        // Icon backgrounds rounded
        [durationIconBackground,
         questionsIconBackground,
         passingIconBackground,
         attemptsIconBackground].forEach { bg in
            bg?.layer.cornerRadius = 14
            bg?.clipsToBounds = true
        }

        // Start button
        startButton.layer.cornerRadius = 22

        // Cancel button
        cancelButton.layer.cornerRadius = 22

        infoLabel.textColor = .gray
    }

    private func setupCloseButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
        closeButtonContainer.addGestureRecognizer(tap)
        closeButtonContainer.isUserInteractionEnabled = true
    }

    // MARK: - Load Quiz Data

    private func loadQuiz() {
        quiz = TestFactory.makeQuiz(
            lessonId: lesson.id,
            lessonName: lesson.name
        )
        // Populate all 4 rows
        durationTitleLabel.text = "Duration"
        durationSubtitleLabel.text = "\(quiz.durationMinutes) mins"

        questionsTitleLabel.text = "Questions"
        questionsSubtitleLabel.text = "\(quiz.questions.count) Multiple Choice"

        passingTitleLabel.text = "Passing Score"
        passingSubtitleLabel.text = "\(quiz.passingPercent)% or higher"

        attemptsTitleLabel.text = "Attempts Remaining"
        attemptsSubtitleLabel.text = "3 of 3"  // later dynamic
    }

    // MARK: - Actions

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    @IBAction func startTapped(_ sender: UIButton) {
        print("Start button tapped")
        print("Delegate is nil?", delegate == nil)

        dismiss(animated: true) {
            print("Modal dismissed, calling delegate")
            self.delegate?.didTapStartTest(quiz: self.quiz)
        }
    }

    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

