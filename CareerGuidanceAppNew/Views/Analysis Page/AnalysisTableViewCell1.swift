import UIKit

class AnalysisTableViewCell1: UITableViewCell {
    
    @IBOutlet weak var domainName: UILabel!
    @IBOutlet weak var domainDescription: UILabel!
    @IBOutlet weak var domainExplore: UIButton!
    
    var onExploreTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
 
        domainName.text = "Web Development"
        domainDescription.text = "Based on your psychometric test results, this is the best domain for you."
        
        domainExplore.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
    }

    @objc func exploreButtonTapped() {

        onExploreTapped?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
