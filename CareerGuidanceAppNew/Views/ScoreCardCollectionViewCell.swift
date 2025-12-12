//
//  ScoreCardCollectionViewCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 10/12/25.
//

import UIKit

class ScoreCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var progressImageView: UIImageView! // or custom ring view
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
            super.awakeFromNib()
            cardContainerView.layer.cornerRadius = 12
            cardContainerView.clipsToBounds = true
            actionButton.layer.cornerRadius = 18
            actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            actionButton.setTitleColor(.white, for: .normal)
            actionButton.backgroundColor = UIColor(hex: "1FA5A1") // your teal
        }

        func configure(with result: TestResult) {
            titleLabel.text = "Overall Score"
            percentageLabel.text = "\(result.score)%"
            descriptionLabel.text = "Great work! You've shown strong skills in \(result.lessonName)."

            progressImageView.image = UIImage(named: "progress_ring_\(result.score)")
        }
}
