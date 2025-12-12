//
//  AnswerStatusCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//

// AnswerStatusCell.swift

import UIKit

class AnswerStatusCell: UITableViewCell {

    @IBOutlet weak var statusBackgroundView: UIView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Ensure the status background is rounded
        statusBackgroundView.layer.cornerRadius = 8
        statusBackgroundView.layer.masksToBounds = true
    }
    
    @IBAction func chevronTapped(_ sender: Any) {
    }
    func configure(with question: QuestionAnswer) {
        questionLabel.text = question.questionText
        statusBackgroundView.backgroundColor = question.isCorrect ? UIColor(hex: "c6ece8") : UIColor(hex: "fde9e6")
        statusImageView.image = UIImage(systemName: question.isCorrect ? "checkmark" : "xmark")
        statusImageView.tintColor = question.isCorrect ? UIColor(hex: "1fa5a1") : UIColor(hex: "e1736c")
    }
}
