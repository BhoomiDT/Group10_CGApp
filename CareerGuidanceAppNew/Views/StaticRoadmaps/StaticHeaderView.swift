//
//  StaticHeaderView.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 08/12/25.
//

import UIKit

class StaticHeaderView: UIView {


    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        // Card styling
        cardContainer.layer.cornerRadius = 16
        cardContainer.clipsToBounds = true

        // Button styling
        startButton.layer.cornerRadius = 28
        startButton.clipsToBounds = true

        bodyLabel.text = "Master core web languages, specialize in front- or back-end, then learn architecture and deployment."
    }
}

extension UIView {
    func sizedForTableHeader() -> UIView {
        let targetSize = CGSize(width: UIScreen.main.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)

        let height = systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height

        frame.size.height = height
        return self
    }
}
