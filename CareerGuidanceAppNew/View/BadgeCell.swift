//
//  FeaturesCollectionViewCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 08/12/25.
//

import UIKit

class BadgeCell: UICollectionViewCell {

    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with badge: Badge) {
            
            // --- 1. Set Badge Content ---
            titleLabel.text = badge.title
            iconImageView.image = UIImage(systemName: badge.iconName)
            
            // --- 2. Apply Styling ---
            
            // Hexagon/Circle Background Color
            iconBackgroundView.backgroundColor = badge.color
            
            // SF Symbol Color (usually white or a light color for contrast)
            iconImageView.tintColor = .white
            
            let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold) // Increase pointSize for larger look
            
            // 2. Apply the configuration when creating the image
            let symbolImage = UIImage(systemName: badge.iconName, withConfiguration: config)
            // --- 3. Apply Unlock Status Visuals ---
        iconImageView.image = symbolImage
            // Dim the cell if the badge is locked
            self.alpha = badge.isUnlocked ? 1.0 : 0.4
            
            // Make the icon background circular (if not done via User Defined Runtime Attributes)
            iconBackgroundView.layer.cornerRadius = iconBackgroundView.frame.height / 2
            iconBackgroundView.layer.masksToBounds = true
            
            // Optional: Apply the corner radius to the white card background
            // if you connected an outlet for it
            if let cardView = cardBackgroundView {
                 cardView.layer.cornerRadius = 12
            }
        }

}
