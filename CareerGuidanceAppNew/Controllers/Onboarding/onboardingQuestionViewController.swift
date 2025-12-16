import UIKit

class onboardingQuestionViewController: UIViewController {

    var questionnaire: Questionnaire!
    var sectionIndex: Int = 0
    var questionIndex: Int = 0
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var optionButton3: UIButton!
    @IBOutlet weak var optionButton4: UIButton!
    @IBOutlet weak var optionButton5: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    private var allOptionButtons: [UIButton] = []
    
    // We still need this for the selection logic
    private let themeColor = UIColor(hex: "1fa5a1")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        configureUI()
        restoreState()
    }
    
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        if questionIndex == 0 {
            navigationItem.hidesBackButton = true
            let backBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backTapped))
            navigationItem.leftBarButtonItem = backBtn
        }
    }

    @objc func backTapped() {
        let alert = UIAlertController(title: "Exit Section?", message: "Progress for this section will be lost.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Exit", style: .destructive) { _ in self.navigationController?.popViewController(animated: true) })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    private func configureUI() {
        if questionnaire == nil { questionnaire = OnboardingManager.shared.questionnaire }
        
        let section = questionnaire.sections[sectionIndex]
        let question = section.questions[questionIndex]

        subtitleLabel.text = "Question \(questionIndex + 1)"
        questionLabel.text = question.qText

        let options = question.options
        allOptionButtons = [optionButton1, optionButton2, optionButton3, optionButton4, optionButton5]

        // Only logic here: Setting text and visibility.
        // Styling (corner radius, etc.) is now handled by Storyboard.
        for (index, button) in allOptionButtons.enumerated() {
            if index < options.count {
                button.setTitle(options[index], for: .normal)
                button.isHidden = false
                
                // Ensure state is reset for recycled views or fresh load
                button.layer.borderWidth = 0
                button.backgroundColor = .white
            } else {
                button.isHidden = true
            }
        }

        let isLast = questionIndex == section.questions.count - 1
        nextButton.setTitle(isLast ? "Submit" : "Next", for: .normal)

        let progress = Float(questionIndex + 1) / Float(section.questions.count)
        progressView.setProgress(progress, animated: true)
    }

    private func restoreState() {
        if let saved = AnswerStorage.shared.getSavedOption(section: sectionIndex, question: questionIndex) {
            updateButtonSelection(selectedIndex: saved)
        }
    }

    @IBAction func optionTapped(_ sender: UIButton) {
        guard let index = allOptionButtons.firstIndex(of: sender) else { return }
        
        AnswerStorage.shared.save(section: sectionIndex, question: questionIndex, optionIndex: index)
        updateButtonSelection(selectedIndex: index)
    }

    private func updateButtonSelection(selectedIndex: Int) {
        for (index, button) in allOptionButtons.enumerated() {
            if index == selectedIndex {
                // We set the border color dynamically here because it depends on selection
                button.layer.borderColor = themeColor.cgColor
                button.layer.borderWidth = 2
                button.backgroundColor = themeColor.withAlphaComponent(0.1)
            } else {
                button.layer.borderWidth = 0
                button.backgroundColor = .white
            }
        }
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        let section = questionnaire.sections[sectionIndex]
        if questionIndex + 1 < section.questions.count {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "QuestionVC") as? onboardingQuestionViewController {
                vc.questionnaire = questionnaire
                vc.sectionIndex = sectionIndex
                vc.questionIndex = questionIndex + 1
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            showSectionSubmitAlert()
        }
    }
    
    func showSectionSubmitAlert() {
        let isLast = sectionIndex == questionnaire.sections.count - 1
        let title = isLast ? "Submit Assessment?" : "Submit Section?"
        let alert = UIAlertController(title: title, message: "Are you sure you want to submit?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { _ in
            OnboardingManager.shared.markSectionCompleted(index: self.sectionIndex)
            self.proceedToNextStep()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func proceedToNextStep() {
        let nextIndex = sectionIndex + 1
        if nextIndex < questionnaire.sections.count {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "IntroVC") as? onboardingSectionIntroViewController {
                vc.sectionIndex = nextIndex
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "analysisRIASEC") as? AnalysisTable {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
