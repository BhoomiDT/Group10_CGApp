import UIKit

class viewBadges: UICollectionViewCell {
   
    @IBOutlet weak var badgesChevron: UIButton!
    @IBOutlet weak var badgesIcon: UIImageView!
    
    var onChevronTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.masksToBounds = true
        setupIcon()
    }
        
    private func setupIcon() {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        badgesIcon.image = UIImage(systemName: "circle.hexagongrid.fill", withConfiguration: config)
        badgesIcon.tintColor = UIColor(hex: "35C759")
    }
    
    @IBAction func badgesOpen(_ sender: Any) {
        onChevronTapped?()
    }
}
