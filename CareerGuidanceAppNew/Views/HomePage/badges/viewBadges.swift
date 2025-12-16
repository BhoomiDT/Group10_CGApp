import UIKit

class viewBadges: UICollectionViewCell {
    
    @IBOutlet weak var badgesChevron: UIButton!
    @IBOutlet weak var badgesIcon: UIImageView!
    
    var onChevronTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
        @IBAction func badgesOpen(_ sender: Any) {
            onChevronTapped?()
        }
    }

