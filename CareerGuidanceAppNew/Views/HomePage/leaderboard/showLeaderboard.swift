import UIKit

class showLeaderboard: UICollectionViewCell {

    @IBOutlet weak var leaderboardIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
        
        setupIcon()
    }
    
    private func setupIcon() {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        leaderboardIcon.image = UIImage(systemName: "chart.bar.fill", withConfiguration: config)
        
        leaderboardIcon.tintColor = UIColor(hex: "A856F7")
       
       
    }
}
