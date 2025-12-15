import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = 16
        selectionStyle = .none
        self.backgroundColor = .appBackground
    }

    func configure(with message: ChatMessage) {
        messageLabel.text = message.text
        
        if message.isUser {
            bubbleView.backgroundColor = UIColor(hex: "C4ECEB")
            messageLabel.textColor = .black
            leftConstraint.isActive = false
            rightConstraint.isActive = true
        } else {
            bubbleView.backgroundColor = .systemGray4
            messageLabel.textColor = .label
            rightConstraint.isActive = false
            leftConstraint.isActive = true
        }
    }
}
