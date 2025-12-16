//
//  RoadmapSectionHeaderCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 09/12/25.
//

import UIKit

class RoadmapSectionHeaderCell: UITableViewCell {
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var dueDateLabel: UILabel!
    //@IBOutlet weak var arrowImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cardContainerView.layer.cornerRadius = 12
        cardContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardContainerView.clipsToBounds = true
    }

    func configure(dueText: String) {
        dueDateLabel.text = dueText
    }
}
