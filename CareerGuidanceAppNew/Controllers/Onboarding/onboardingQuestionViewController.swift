import UIKit

class onboardingQuestionViewController: UIViewController {

    var questionnaire: Questionnaire!
    var sectionIndex: Int = 0
    var questionIndex: Int = 0       

    // MARK: - Outlets
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var optionButton3: UIButton!
    @IBOutlet weak var optionButton4: UIButton!
    @IBOutlet weak var optionButton5: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavigation()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

    }
    
    
   
    
    // MARK: - 1. Back Button Logic (Safety Check)
    private func setupNavigation() {
        // If this is the FIRST question of the section, replace the back button
        if questionIndex == 0 {
            navigationItem.hidesBackButton = true
            let backBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(backTapped))
            navigationItem.leftBarButtonItem = backBtn
        }
    }

    @objc func backTapped() {
        let alert = UIAlertController(title: "Exit Section?",
                                      message: "If you go back now, your progress for this section will be lost.",
                                      preferredStyle: .alert)
        
        let exitAction = UIAlertAction(title: "Exit", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(exitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    // MARK: - UI Configuration
    private func configureUI() {
        if questionnaire == nil {
            questionnaire = OnboardingManager.shared.questionnaire
        }
        
        let section = questionnaire.sections[sectionIndex]
        let question = section.questions[questionIndex]

        subtitleLabel.text = String("Question \(questionIndex+1)")
        questionLabel.text = String(question.qText)

        let options = question.options
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4, optionButton5]

        for i in 0..<buttons.count {
            if i < options.count {
                buttons[i]?.setTitle(options[i], for: .normal)
                buttons[i]?.isHidden = false
            } else {
                buttons[i]?.isHidden = true
            }
        }

        // Logic: Is this the last question of the CURRENT section?
        let isLastQuestionInCurrentSection = questionIndex == section.questions.count - 1
        
        // Requirement: "Section wise last button should be Submit"
        nextButton.setTitle(isLastQuestionInCurrentSection ? "Submit" : "Next", for: .normal)

        // Progress bar update
        let totalQuestions = section.questions.count
        let current = questionIndex + 1
        let progress = Float(current) / Float(totalQuestions)
        progressView.setProgress(progress, animated: true)
    }

    // MARK: - Actions

    @IBAction func nextTapped(_ sender: UIButton) {
        let section = questionnaire.sections[sectionIndex]
        
        // 1. Check if there are MORE questions in this section
        if questionIndex + 1 < section.questions.count {
            // Simply go to the next question (No Alert needed for "Next")
            if let vc = storyboard?.instantiateViewController(withIdentifier: "QuestionVC") as? onboardingQuestionViewController {
                vc.questionnaire = questionnaire
                vc.sectionIndex = sectionIndex
                vc.questionIndex = questionIndex + 1
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            // 2. This is the LAST question of the section (Button is "Submit")
            // Requirement: "if section submit then too the alert shall come up"
            showSectionSubmitAlert()
        }
    }
    
    // MARK: - 2. Submit Alert Logic (For ANY section end)
    func showSectionSubmitAlert() {
        let isLastSectionOfApp = sectionIndex == questionnaire.sections.count - 1
        let title = isLastSectionOfApp ? "Submit Assessment?" : "Submit Section?"
        let message = isLastSectionOfApp ? "Are you sure you want to finish the entire questionnaire?" : "Are you sure you want to submit this section and proceed?"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            self.proceedToNextStep()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func proceedToNextStep() {
       
        OnboardingManager.shared.markSectionCompleted(index: sectionIndex)
        
        let nextSectionIndex = sectionIndex + 1
       
        if nextSectionIndex < questionnaire.sections.count {
        
            if let introVC = storyboard?.instantiateViewController(withIdentifier: "IntroVC") as? onboardingSectionIntroViewController {
                introVC.sectionIndex = nextSectionIndex
                navigationController?.pushViewController(introVC, animated: true)
            }
        } else {
            if let analysisVC = storyboard?.instantiateViewController(withIdentifier: "analysisRIASEC") as? AnalysisTable {
                navigationController?.pushViewController(analysisVC, animated: true)
            } else {
                print("Error: Could not find Analysis Page (ID: analysisRIASEC)")
            }
        }
    }
}
