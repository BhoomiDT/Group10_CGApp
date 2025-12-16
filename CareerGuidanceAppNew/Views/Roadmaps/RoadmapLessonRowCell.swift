//
//  RoadmapLessonRowCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 09/12/25.
//

import UIKit

protocol RoadmapLessonRowCellDelegate: AnyObject {
    //called when status button tapped
    func roadmapLessonRowCell(_ cell: RoadmapLessonRowCell, didTapStatusFor lesson: Lesson)
}

class RoadmapLessonRowCell: UITableViewCell {
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var lessonTitleLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
        // delegate
        weak var delegate: RoadmapLessonRowCellDelegate?

        // keep lesson so we can forward it when tapped
        private var lesson: Lesson?
    
    private let separatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        cardContainerView.backgroundColor = .white
        cardContainerView.clipsToBounds = true
        cardContainerView.layer.cornerRadius = 12

        // remove UIButton.Configuration if one exists (iOS 15+)
        if #available(iOS 15.0, *) {
            statusButton.configuration = nil
        }

        // make sure the button behaves like a custom button
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.layer.cornerRadius = 14
        statusButton.clipsToBounds = true

        // padding & label behaviour
        statusButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 14, bottom: 6, right: 14)
        statusButton.titleLabel?.adjustsFontSizeToFitWidth = true
        statusButton.addTarget(self, action: #selector(statusButtonTapped(_:)), for: .touchUpInside)
            
        // separator (created in code)
        cardContainerView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 12),
            separatorView.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -12),
            separatorView.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        statusButton.backgroundColor = .clear
        statusButton.setTitleColor(.label, for: .normal)
        statusButton.setTitle("", for: .normal)
    }

    func configure(with lesson: Lesson) {
        self.lesson = lesson
        lessonTitleLabel.text = lesson.name

        // Set title first
        statusButton.setTitle(lesson.status.rawValue, for: .normal)
        
        // Set background & title color explicitly for normal state
        switch lesson.status {
        case .seeResults:
            statusButton.backgroundColor = UIColor(hex: "1FA5A1")
            statusButton.setTitleColor(.white, for: .normal)
        case .startTest:
            statusButton.backgroundColor = .systemGray5
            statusButton.setTitleColor(.darkGray, for: .normal)
        }
    }

    @objc private func statusButtonTapped(_ sender: UIButton) {
        guard let lesson = lesson else { return }

            // temporarily darken
//            if let bg = sender.backgroundColor {
//                sender.backgroundColor = bg.darker(by: 0.15)
//            }

            // restore after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.configure(with: lesson)
            }

            delegate?.roadmapLessonRowCell(self, didTapStatusFor: lesson)
        }
    
    // Helper to adjust corner rounding and separator visibility
    func setCorners(topLeft: Bool, topRight: Bool, bottomLeft: Bool, bottomRight: Bool, hideSeparator: Bool) {
        var maskedCorners: CACornerMask = []
        if topLeft { maskedCorners.insert(.layerMinXMinYCorner) }
        if topRight { maskedCorners.insert(.layerMaxXMinYCorner) }
        if bottomLeft { maskedCorners.insert(.layerMinXMaxYCorner) }
        if bottomRight { maskedCorners.insert(.layerMaxXMaxYCorner) }
        cardContainerView.layer.maskedCorners = maskedCorners
        separatorView.isHidden = hideSeparator
    }
}

