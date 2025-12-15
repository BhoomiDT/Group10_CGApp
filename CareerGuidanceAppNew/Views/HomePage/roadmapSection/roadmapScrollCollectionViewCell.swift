
//
//  roadmapScrollCollectionViewCell.swift
//  HomePage
//
//  Created by SDC-USER on 08/12/25.
//

import UIKit


class roadmapScrollCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var circularProgressContainer: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var milestoneValueLabel: UILabel!
    
    // MARK: - Private Layers
    private let shapeLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCircleLayers()
    }
    
    // MARK: - Setup
    func setupCardStyle() {
        self.backgroundColor = .clear
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        
        self.layer.cornerRadius = 20
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
    }

    func configure(title: String, subtitle: String, percentage: Int, milestone: String) {
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        percentageLabel.text = "\(percentage)%"
        milestoneValueLabel.text = milestone
        
        let percentageFloat = CGFloat(percentage) / 100.0
        drawProgress(percentage: percentageFloat)
    }

    // MARK: - Circle Drawing
    private func setupCircleLayers() {
        trackLayer.removeFromSuperlayer()
        shapeLayer.removeFromSuperlayer()
        
        let centerPoint = CGPoint(x: circularProgressContainer.bounds.midX, y: circularProgressContainer.bounds.midY)
        let radius = (circularProgressContainer.bounds.width / 2) - 8
        
        let start = -CGFloat.pi / 2
        let end = start + (2 * CGFloat.pi)
        
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: start, endAngle: end, clockwise: true)
    
       
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.systemGray6.cgColor
        trackLayer.lineWidth = 8
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        circularProgressContainer.layer.addSublayer(trackLayer)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.appTeal.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0 // Animation starts from 0
        circularProgressContainer.layer.addSublayer(shapeLayer)
    }
    
    private func drawProgress(percentage: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = percentage
        animation.duration = 1.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "progressAnim")
    }
}
