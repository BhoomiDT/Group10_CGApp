//
//  AnalysisTableViewCell2.swift
//  CareerGuidance1
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class AnalysisTableViewCell2: UITableViewCell {
    @IBOutlet weak var labelCategory: UILabel!  // The RIASEC label (e.g., "Realistic")
        @IBOutlet weak var progressBar: UIProgressView! // The actual progress bar
        @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelTopConstraint: NSLayoutConstraint!
        @IBOutlet weak var progressBottomConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let desiredThickness: CGFloat = 0.5
                
                progressBar.transform = CGAffineTransform(scaleX: 1.0, y: desiredThickness)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
