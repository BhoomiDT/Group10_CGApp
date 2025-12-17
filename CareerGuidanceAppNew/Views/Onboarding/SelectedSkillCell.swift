//
//  SelectedSkillCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//

import UIKit

protocol SelectedSkillCellDelegate: AnyObject {
    func selectedCellDidTapRemove(_ cell: SelectedSkillCell)
}

class SelectedSkillCell: UITableViewCell {
    @IBOutlet weak var leftButton: UIButton!  
    @IBOutlet weak var titleLabel: UILabel!

    weak var delegate: SelectedSkillCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // visual polish
        leftButton.layer.cornerRadius = 18  // half of 36
        leftButton.clipsToBounds = true
        // prevent button from dimming the cell
        leftButton.adjustsImageWhenHighlighted = true
    }

    @IBAction func leftButtonTapped(_ sender: UIButton) {
        delegate?.selectedCellDidTapRemove(self)
    }
}
