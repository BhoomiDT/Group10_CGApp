//
//  SuggestionSkillCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//

import UIKit

protocol SuggestionSkillCellDelegate: AnyObject {
    func suggestionCellDidTapAdd(_ cell: SuggestionSkillCell)
}

class SuggestionSkillCell: UITableViewCell {
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    weak var delegate: SuggestionSkillCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        leftButton.layer.cornerRadius = 18
        leftButton.clipsToBounds = true
    }

    @IBAction func leftButtonTapped(_ sender: UIButton) {
        delegate?.suggestionCellDidTapAdd(self)
    }
}
