//
//  StrengthTableViewCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 11/12/25.
//

import UIKit

class StrengthTableViewCell: UITableViewCell {

    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    // Programmatic separator
    private let separatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none

        // Card container rounding
        cardContainerView.layer.cornerRadius = 12
        cardContainerView.clipsToBounds = true

        // Icon background
        iconBackgroundView.layer.cornerRadius = 8
        iconBackgroundView.clipsToBounds = true

        setupSeparator()
    }

    private func setupSeparator() {
        cardContainerView.addSubview(separatorView)

        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 60),
            separatorView.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func configure(with item: StrengthItem, isLast: Bool) {
        titleLabel.text = item.title

        // hide separator for last row
        separatorView.isHidden = isLast

        // icon image
        iconImageView.image = UIImage(systemName: "hand.thumbsup.fill")?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor(hex: "1FA5A1")
    }
}
