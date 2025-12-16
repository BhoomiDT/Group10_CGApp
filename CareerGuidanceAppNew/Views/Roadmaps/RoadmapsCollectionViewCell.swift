//
//  RoadmapsCollectionViewCell.swift
//  CareerGuidance1
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

// RoadmapCardCell.swift

class RoadmapsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var illustrationImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //1. Card
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .systemBackground
        
        //2. Shadow Effect
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false // Crucial: must be false for shadow to show
        
        //3. Label Styling
        self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.titleLabel.textColor = .label
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.descriptionLabel.textColor = .secondaryLabel
    }
    
    func configure(image: UIImage, title: String, description: String) {
        illustrationImageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
