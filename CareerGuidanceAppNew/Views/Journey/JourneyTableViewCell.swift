//
//  JourneyTableViewCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 28/11/25.
//

import UIKit

class JourneyTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear  
        contentView.backgroundColor = .clear
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 16
        cardView.clipsToBounds = true

        iconBackgroundView.layer.cornerRadius = 20   // half of width/height
        iconBackgroundView.clipsToBounds = true

        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        iconImageView.preferredSymbolConfiguration = config
    }

    func configure(with item: JourneyItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle

        iconImageView.image = UIImage(systemName: item.iconName)
        iconImageView.tintColor = item.iconColor
        iconBackgroundView.backgroundColor = item.iconBackgroundColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
