//
//  AnalysisTableViewCell1.swift
//  CareerGuidance1
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class AnalysisTableViewCell1: UITableViewCell {
    @IBOutlet weak var domainName: UILabel!
    @IBOutlet weak var domainDescription: UILabel!
    
    @IBOutlet weak var domainExplore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        domainName.text = "Web Development"
        domainDescription.text = "Based on your psychometric test results, this is the best domain for you. "
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
