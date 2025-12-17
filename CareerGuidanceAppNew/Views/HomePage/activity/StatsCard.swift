
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
        setupStyle()
        setupSeparators()
    }

    private func setupStyle() {
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
    

//    private func setupSeparators() {
//        [0.66, 1.33].forEach { m in
//            let v = UIView()
//            v.backgroundColor = .lightGray.withAlphaComponent(0.4)
//            v.translatesAutoresizingMaskIntoConstraints = false
//            addSubview(v)
//            NSLayoutConstraint.activate([
//                v.widthAnchor.constraint(equalToConstant: 1),
//                v.topAnchor.constraint(equalTo: xpTitle.topAnchor),
//                v.bottomAnchor.constraint(equalTo: xpValue.bottomAnchor),
//                NSLayoutConstraint(item: v, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: m, constant: 0)
//            ])
//        }
//    }

    private func setupSeparators() {
            // MARK: - FIX 2: Use Width Multipliers (1/3 and 2/3)
            // We use the 'trailing' (width) attribute to calculate exact thirds.
            let multipliers: [CGFloat] = [1.0/3.0, 2.0/3.0]
            
            multipliers.forEach { m in
                let v = UIView()
                v.backgroundColor = .lightGray.withAlphaComponent(0.4)
                v.translatesAutoresizingMaskIntoConstraints = false
                addSubview(v)
                
                NSLayoutConstraint.activate([
                    v.widthAnchor.constraint(equalToConstant: 1),
                    // Anchor top/bottom to the titles/values to match height
                    v.topAnchor.constraint(equalTo: xpTitle.topAnchor),
                    v.bottomAnchor.constraint(equalTo: xpValue.bottomAnchor),
                    
                    // Place the separator at 33% and 66% of the TOTAL WIDTH (Trailing)
                    NSLayoutConstraint(item: v,
                                       attribute: .centerX,
                                       relatedBy: .equal,
                                       toItem: self,
                                       attribute: .trailing, // Use Trailing (Width) instead of CenterX
                                       multiplier: m,
                                       constant: 0)
                ])
            }
        }
    
    func configure(with stats: UserStats) {
        let isComplete = OnboardingManager.shared.isOnboardingFullyComplete()
        let xp = isComplete ? stats.xp : 100
        let streak = isComplete ? stats.streak : 1
        let badges = isComplete ? stats.badges : 1
        
        setupValue(label: xpValue, val: "\(xp)", icon: "star.fill", color: .systemYellow)
        setupValue(label: streakValue, val: "\(streak)", icon: "flame.fill", color: .systemRed)
        setupValue(label: badgeValue, val: "\(badges)", icon: "shield.lefthalf.filled", color: .systemPurple)
    }

    private func setupValue(label: UILabel, val: String, icon: String, color: UIColor) {
        let att = NSTextAttachment()
        if let img = UIImage(systemName: icon, withConfiguration: UIImage.SymbolConfiguration(scale: .medium))?.withTintColor(color, renderingMode: .alwaysOriginal) {
            att.image = img
            att.bounds = CGRect(x: 0, y: -2, width: img.size.width, height: img.size.height)
        }
        let str = NSMutableAttributedString(string: "\(val) ")
        str.append(NSAttributedString(attachment: att))
        label.attributedText = str
        
    }
}
