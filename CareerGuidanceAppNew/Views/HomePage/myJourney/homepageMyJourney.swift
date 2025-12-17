import UIKit

class homepageMyJourney: UICollectionViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewIcon: UIImageView!
    
    @IBOutlet weak var row1ImageView: UIImageView!
    @IBOutlet weak var row2ImageView: UIImageView!
    @IBOutlet weak var row3ImageView: UIImageView!
    
    @IBOutlet weak var row1ValueLabel: UILabel!
    @IBOutlet weak var row2ValueLabel: UILabel!
    @IBOutlet weak var row3ValueLabel: UILabel!

    @IBOutlet weak var chevronImageView: UIButton!
    var onChevronTapped: (() -> Void)?

        override func awakeFromNib() {
            super.awakeFromNib()
            
//            setupIcons()
            
            overviewLabel.textColor = .appTeal
            
           
            setupChevronInteraction()
        }
        
        private func setupChevronInteraction() {
          
            chevronImageView.isUserInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleChevronTap))
            chevronImageView.addGestureRecognizer(tapGesture)
        }
    @objc private func handleChevronTap() {
            
            onChevronTapped?()
        }
    func configure(days: String, quizzes: String, quests: String) {
       
        let isComplete = OnboardingManager.shared.isOnboardingFullyComplete()
        
        let displayDays = isComplete ? days : "0"
        let displayQuizzes = isComplete ? quizzes : "0"
        let displayQuests = isComplete ? quests : "0"
        
        setupValue(label: row1ValueLabel, value: displayDays)
        setupValue(label: row2ValueLabel, value: displayQuizzes)
        setupValue(label: row3ValueLabel, value: displayQuests)
    }

    
//    private func setupIcons() {
//        let headerConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
//        
//    }

    private func configureIcon(imageView: UIImageView, symbolName: String, color: UIColor) {
//        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .center
    }
    
    private func setupValue(label: UILabel, value: String) {
        label.text = value
    }
}
