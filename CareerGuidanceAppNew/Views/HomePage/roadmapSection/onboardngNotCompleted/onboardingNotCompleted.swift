import UIKit

class onboardingNotCompleted: UICollectionViewCell {

    @IBOutlet weak var progressBarOnboarding: UIProgressView!
    @IBOutlet weak var continuePersonalisationButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
        continuePersonalisationButton.tintColor = .appTeal
        progressBarOnboarding.progressTintColor = .appTeal
    }
}
