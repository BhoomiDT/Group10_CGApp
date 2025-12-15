//
//  viewBadges.swift
//  HomePage
//
//  Created by SDC-USER on 10/12/25.
//

import UIKit

class viewBadges: UICollectionViewCell {
   
    @IBOutlet weak var badgesIcon: UIImageView!
    override func awakeFromNib() {
            super.awakeFromNib()
            
            self.backgroundColor = .white
            self.layer.cornerRadius = 20
            self.layer.masksToBounds = true
            
            
            setupIcon()
        }
        
        private func setupIcon() {
            let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
            badgesIcon.image = UIImage(systemName: "circle.hexagongrid.fill", withConfiguration: config)
            
           badgesIcon.tintColor = UIColor(hex: "35C759")
           
           
        }
    }

    

