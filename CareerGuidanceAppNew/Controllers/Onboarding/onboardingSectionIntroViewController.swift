import UIKit

class onboardingSectionIntroViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnSkip: UIButton!

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
            if let nextIntro = storyboard?.instantiateViewController(withIdentifier: "IntroVC") as? onboardingSectionIntroViewController {
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
