//
//  SelectedTableViewCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 11/12/25.
//

import UIKit

class SelectedTableViewCell: UITableViewCell {
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            minusButton.removeTarget(nil, action: nil, for: .allEvents)
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
