import UIKit

class AnalysisTableViewCell1: UITableViewCell {
    
    @IBOutlet weak var domainName: UILabel!
    @IBOutlet weak var domainDescription: UILabel!
    @IBOutlet weak var domainExplore: UIButton!
    
    // 1. Add a closure to handle the action
    var onExploreTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        domainName.text = "Web Development"
        domainDescription.text = "Based on your psychometric test results, this is the best domain for you."
        
        // Style the button
        domainExplore.layer.cornerRadius = 12
        domainExplore.clipsToBounds = true
        
        // 2. Add the target programmatically (No storyboard connection needed for action)
        domainExplore.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
    }

    @objc func exploreButtonTapped() {
        // 3. Trigger the closure
        onExploreTapped?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
