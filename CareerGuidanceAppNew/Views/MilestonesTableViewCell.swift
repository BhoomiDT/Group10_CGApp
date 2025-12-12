//
//  MilestonesTableViewCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 02/12/25.
//

import UIKit

class MilestonesTableViewCell: UITableViewCell {
    
        @IBOutlet weak var containerView: UIView!
        @IBOutlet weak var iconBackgroundView: UIView!
        @IBOutlet weak var iconImageView: UIImageView!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var subtitleLabel: UILabel!

        override func awakeFromNib() {
            super.awakeFromNib()

            // Rounded card
            containerView.layer.cornerRadius = 16
            containerView.clipsToBounds = true
            selectionStyle = .none
            iconBackgroundView.layer.cornerRadius = 8
            iconBackgroundView.clipsToBounds = true
        }
    override func setSelected(_ selected: Bool, animated: Bool) { }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
    func configure(title: String,
                       subtitle: String,
                       iconName: String,
                       iconColor: UIColor,
                       bgColor: UIColor) {

            titleLabel.text = title
            subtitleLabel.text = subtitle
            iconImageView.image = UIImage(systemName: iconName)
            iconImageView.tintColor = iconColor
            iconBackgroundView.backgroundColor = bgColor
        }
}
