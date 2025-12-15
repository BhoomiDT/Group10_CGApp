//
//  trendingHomePage.swift
//  HomePage
//
//  Created by SDC-USER on 10/12/25.
//

import UIKit

class trendingHomePage: UICollectionViewCell {

    @IBOutlet weak var trendingIcon: UIImageView!
    @IBOutlet weak var trendingLabel: UILabel!
    @IBOutlet weak var trendingDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
     
       
        
    }

    func configure(item: TrendingItem) {
        trendingLabel.text = item.title
        trendingDesc.text = item.description
        trendingIcon.image = UIImage(named: item.imageName)
    }
}
