import UIKit

class onboardingSectionIntroViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    var questionnaire: Questionnaire?

    // MARK: - Properties
    var sectionIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContent()
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - UI Layout Fix
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
        iconBackgroundView.layer.cornerRadius = iconBackgroundView.frame.height / 2
        iconBackgroundView.layer.masksToBounds = true
    }
    private var hasShownWelcomeModal = false

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            // Only trigger on Section 0 and only if not already shown
            if sectionIndex == 0 && !hasShownWelcomeModal {
                presentWelcomePage()
            }
        }

        private func presentWelcomePage() {
            let storyboard = UIStoryboard(name: "WelcomePage", bundle: nil)
            if let welcomeVC = storyboard.instantiateViewController(withIdentifier: "WelcomePage") as? WelcomeViewController {
                
                // Set the style to pageSheet so your 85% custom height works
                welcomeVC.modalPresentationStyle = .pageSheet
                
                // Set flag to true before presenting
                hasShownWelcomeModal = true
                
                self.present(welcomeVC, animated: true, completion: nil)
            }
        }
    
    func configureContent() {
        let sections = OnboardingManager.shared.questionnaire.sections
        guard sectionIndex < sections.count else { return }
        let sectionData = sections[sectionIndex]
        
        titleLabel.text = sectionData.title
        subtitleLabel.text = sectionData.subtitle
        
        if let image = UIImage(systemName: sectionData.symbolName) {
            imageView.image = image
            imageView.tintColor = .appTeal
        }
        
        btnSkip.isHidden = (sectionIndex == 0)
    }

    // MARK: - Navigation Logic
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        if sectionIndex == 0 {
            OnboardingManager.shared.markSectionCompleted(index: 0)
            if let nextIntro = storyboard?.instantiateViewController(withIdentifier: "introVC") as? onboardingSectionIntroViewController {
                nextIntro.sectionIndex = 1
                navigationController?.pushViewController(nextIntro, animated: true)
            }
        }
        else if sectionIndex == 1 {
            if let techVC = storyboard?.instantiateViewController(withIdentifier: "technicalSkills") as? SkillsViewController {
                navigationController?.pushViewController(techVC, animated: true)
            }
        }
        else {
            if let questionVC = storyboard?.instantiateViewController(withIdentifier: "QuestionVC") as? onboardingQuestionViewController {
                        
                
                        questionVC.questionnaire = OnboardingManager.shared.questionnaire
                        
                        questionVC.sectionIndex = self.sectionIndex
                        navigationController?.pushViewController(questionVC, animated: true)
                    }
        }
    }

    @IBAction func skipButtonTapped(_ sender: UIButton) {
        let homeStoryboard = UIStoryboard(name: "HomePageProfileNew", bundle: nil)
        
        if let homeVC = homeStoryboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
            navigationController?.setViewControllers([homeVC], animated: true)
        }
    }
}
