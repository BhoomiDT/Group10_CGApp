import UIKit

class onboardingQuestionViewController: UIViewController {

    var questionnaire: Questionnaire!
    var sectionIndex: Int = 0      // which section
    var questionIndex: Int = 0     // which question in section

    // MARK: - Outlets (hook to storyboard)
    //@IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var optionButton3: UIButton!
    @IBOutlet weak var optionButton4: UIButton!
    @IBOutlet weak var optionButton5: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        let section = questionnaire.sections[sectionIndex]
        let question = section.questions[questionIndex]

        //titleLabel.text = section.title
        subtitleLabel.text = String("Question \(questionIndex+1)")
        questionLabel.text = String(question.qText)

        let options = question.options
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4,optionButton5]

        for i in 0..<buttons.count {
            if i < options.count {
                buttons[i]?.setTitle(options[i], for: .normal)
                buttons[i]?.isHidden = false
            } else {
                buttons[i]?.isHidden = true
            }
        }

        let isLastQuestionInSection = questionIndex == section.questions.count - 1
        let isLastSection = sectionIndex == questionnaire.sections.count - 1

        nextButton.setTitle(isLastQuestionInSection && isLastSection ? "Finish" : "Next", for: .normal)

        // MARK: - Progress bar update
        let totalQuestions = section.questions.count
        let current = questionIndex + 1
        let progress = Float(current) / Float(totalQuestions)
        progressView.setProgress(progress, animated: true)
    }

    // MARK: - Actions

    @IBAction func optionTapped(_ sender: UIButton) {
        // later: store which option was selected in a response model
        print("Selected option: \(sender.currentTitle ?? "")")
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        let section = questionnaire.sections[sectionIndex]

        // More questions in same section → push next QuestionVC
        if questionIndex + 1 < section.questions.count {
            guard let vc = storyboard?.instantiateViewController(
                withIdentifier: "QuestionVC"
            ) as? onboardingQuestionViewController else { return }

            vc.questionnaire = questionnaire
            vc.sectionIndex = sectionIndex
            vc.questionIndex = questionIndex + 1

            navigationController?.pushViewController(vc, animated: true)
            return
        }

        // Section finished → next section intro
        let nextSectionIndex = sectionIndex + 1
        if nextSectionIndex < questionnaire.sections.count,
           let introVC = storyboard?.instantiateViewController(
                withIdentifier: "IntroVC"
           ) as? onboardingSectionIntroViewController {

            introVC.questionnaire = questionnaire
            introVC.sectionIndex = nextSectionIndex

            navigationController?.pushViewController(introVC, animated: true)
        } else {
            // All sections done – finish onboarding
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
