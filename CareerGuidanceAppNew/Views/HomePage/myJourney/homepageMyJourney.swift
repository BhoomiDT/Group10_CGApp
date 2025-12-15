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

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        setupIcons()
        
        overviewLabel.textColor = .appTeal
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

    
    private func setupIcons() {
        let headerConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        overviewIcon.image = UIImage(systemName: "clock", withConfiguration: headerConfig)
        overviewIcon.tintColor = .appTeal
        overviewIcon.contentMode = .scaleAspectFit

        configureIcon(
            imageView: row1ImageView,
            symbolName: "calendar",
            color: .systemBlue
        )
        
        configureIcon(
            imageView: row2ImageView,
            symbolName: "target",
            color: .systemGreen
        )
        
        configureIcon(
            imageView: row3ImageView,
            symbolName: "trophy.fill",
            color: .systemOrange
        )
    }

    private func configureIcon(imageView: UIImageView, symbolName: String, color: UIColor) {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        imageView.image = UIImage(systemName: symbolName, withConfiguration: config)
        
        imageView.tintColor = color
        imageView.backgroundColor = color.withAlphaComponent(0.15)
        
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .center
    }
    
    private func setupValue(label: UILabel, value: String) {
        label.text = value
        // Match the bold style from your design
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
    }
}
