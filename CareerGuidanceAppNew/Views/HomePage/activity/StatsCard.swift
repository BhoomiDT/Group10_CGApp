import UIKit

class StatsCard: UICollectionViewCell {

    @IBOutlet weak var activityIcon: UIImageView!
    @IBOutlet weak var activityTitle: UILabel!

    @IBOutlet weak var xpTitle: UILabel!
    @IBOutlet weak var xpValue: UILabel!

    @IBOutlet weak var streakTitle: UILabel!
    @IBOutlet weak var streakValue: UILabel!

    @IBOutlet weak var badgeTitle: UILabel!
    @IBOutlet weak var badgeValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        addVerticalSeparators()
    }

    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2

        activityTitle.text = "Activity"
        activityTitle.textColor = .appTeal
        activityIcon.image = UIImage(systemName: "flag.pattern.checkered")
        activityIcon.tintColor = .appTeal

        xpTitle.text = "Total XP"
        streakTitle.text = "Day Streaks"
        badgeTitle.text = "Badges"
    }

    func configure(with stats: UserStats) {
       
        let isComplete = OnboardingManager.shared.isOnboardingFullyComplete()
        let displayStreak = isComplete ? stats.streak : 1
        let displayBadges = isComplete ? stats.badges : 0
        let displayXP = isComplete ? stats.xp : 100
        setupValue(label: xpValue, value: "\(displayXP)", icon: "star.fill", color: .systemYellow)
        setupValue(label: streakValue, value: "\(displayStreak)", icon: "flame.fill", color: .systemRed)
        setupValue(label: badgeValue, value: "\(displayBadges)", icon: "shield.lefthalf.filled", color: .systemPurple)
    }

    private func setupValue(label: UILabel, value: String, icon: String, color: UIColor) {
        let config = UIImage.SymbolConfiguration(scale: .medium)
        let attachment = NSTextAttachment()

        if let image = UIImage(systemName: icon, withConfiguration: config)?
            .withTintColor(color, renderingMode: .alwaysOriginal) {
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -1, width: image.size.width, height: image.size.height)
        }

        let final = NSMutableAttributedString(string: "\(value) ")
        final.append(NSAttributedString(attachment: attachment))
        label.attributedText = final
    }

    private func addVerticalSeparators() {
        [0.66, 1.33].forEach {
            let v = UIView()
            v.backgroundColor = .lightGray.withAlphaComponent(0.4)
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
            
            NSLayoutConstraint.activate([
                v.widthAnchor.constraint(equalToConstant: 1),
                v.topAnchor.constraint(equalTo: xpTitle.topAnchor),
                v.bottomAnchor.constraint(equalTo: xpValue.bottomAnchor),
                NSLayoutConstraint(item: v, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: $0, constant: 0)
            ])
        }
    }
}
