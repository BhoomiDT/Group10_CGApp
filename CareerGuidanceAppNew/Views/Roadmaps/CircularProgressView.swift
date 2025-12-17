import UIKit

class CircularProgressView: UIView {

    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private var isConfigured = false

    override func layoutSubviews() {
        super.layoutSubviews()

        if !isConfigured {
            configureLayers()
            isConfigured = true
        }

        updatePath()
    }

    private func configureLayers() {
        trackLayer.strokeColor = UIColor.systemGray5.cgColor
        trackLayer.lineWidth = 12
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        
        let color = UIColor(hex: "1fa5a1")
        progressLayer.strokeColor = color.cgColor
        progressLayer.lineWidth = 12
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0

        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }

    private func updatePath() {
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - 10

        let path = UIBezierPath(
            arcCenter: centerPoint,
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: 1.5 * CGFloat.pi,
            clockwise: true
        )

        trackLayer.path = path.cgPath
        progressLayer.path = path.cgPath
    }

    func setProgress(_ value: CGFloat, animated: Bool = true) {
        let clamped = min(max(value, 0), 1)

        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = clamped
            animation.duration = 1.0
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

            progressLayer.strokeEnd = clamped
            progressLayer.add(animation, forKey: "progress")
        } else {
            progressLayer.strokeEnd = clamped
        }
    }
}
