
import UIKit

class aiCellView: UITableViewCell {
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubbleWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleTrailingConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubbleView.layer.cornerRadius = 16
        bubbleView.layer.masksToBounds = true
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        messageLabel.numberOfLines = 0
        
        // ADDED: This adds 16px padding from the screen edges
        bubbleLeadingConstraint.constant = 16
        bubbleTrailingConstraint.constant = 16
    }

    func configure(with message: ChatMessage) {
        messageLabel.text = message.text
        
        if message.isUser {
            bubbleView.backgroundColor = UIColor(hex: "C4ECEB")
            messageLabel.textColor = .label
            
            bubbleLeadingConstraint.isActive = false
            bubbleTrailingConstraint.isActive = true
        } else {
            bubbleView.backgroundColor = .systemGray5
            messageLabel.textColor = .label
            
            bubbleTrailingConstraint.isActive = false
            bubbleLeadingConstraint.isActive = true
        }
    }
}
