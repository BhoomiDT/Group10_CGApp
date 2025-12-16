
import UIKit

class showLeaderboard: UICollectionViewCell {

    @IBOutlet weak var leaderboardIcon: UIImageView!
    @IBOutlet weak var leaderboardChevron: UIButton!
    
    var onChevronTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
   
    
    @IBAction func leaderboardact(_ sender: Any) {
        onChevronTapped?()
    }
}
