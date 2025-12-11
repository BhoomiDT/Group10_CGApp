import UIKit

class onboardingSectionIntroViewController: UIViewController {

    // MARK: - Model
    var questionnaire: Questionnaire!   // injected / created
    var sectionIndex: Int = 0           // which section intro is this?

    // MARK: - Outlets (hook these to storyboard)

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! 
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var iconBackgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // First intro creates the model
        if questionnaire == nil {
            questionnaire = Questionnaire()
        }

        configureUI()
        styleCircle()
    }

    private func configureUI() {
        let section = questionnaire.sections[sectionIndex]
        iconImageView.image = UIImage(systemName: section.symbolName)
        titleLabel.text = section.title
        subtitleLabel.text = section.subtitle
    }
    
    private func styleCircle() {
        iconBackgroundView.layer.cornerRadius = iconBackgroundView.bounds.height/2
        iconBackgroundView.clipsToBounds = true
    }

    @IBAction func continueTapped(_ sender: UIButton) {
        // Go to first question in this section
        guard let vc = storyboard?.instantiateViewController(
            withIdentifier: "QuestionVC"
        ) as? onboardingQuestionViewController else { return }

        vc.questionnaire = questionnaire
        vc.sectionIndex = sectionIndex
        vc.questionIndex = 0

        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func skipTapped(_ sender: UIButton) {
        // Skip this section → next section intro
        let nextSectionIndex = sectionIndex + 1

        guard nextSectionIndex < questionnaire.sections.count,
              let nextIntro = storyboard?.instantiateViewController(
                withIdentifier: "IntroVC"
              ) as? onboardingSectionIntroViewController else {

            // no more sections → finish flow however you want
            navigationController?.popToRootViewController(animated: true)
            return
        }

        nextIntro.questionnaire = questionnaire
        nextIntro.sectionIndex = nextSectionIndex
        navigationController?.pushViewController(nextIntro, animated: true)
    }
}
