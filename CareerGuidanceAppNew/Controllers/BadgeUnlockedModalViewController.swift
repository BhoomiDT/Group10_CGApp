//
//  BadgeUnlockedModalViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 11/12/25.
//

import UIKit

class BadgeUnlockedModalViewController: UIViewController {

    var badge: Badge!
    var modalTitleString: String?
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dismissButtonView: UIView!
    @IBOutlet weak var modalCardCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var modalCardView: UIView!
    @IBOutlet weak var largeIconBackgroundView: UIView!
    @IBOutlet weak var largeIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Set the main view background to translucent black
        view.backgroundColor = .clear
                
                // 2. Configure background styling (make it circular)
                // We use layoutIfNeeded() to ensure the frame is calculated before setting corner radius
                largeIconBackgroundView.layoutIfNeeded()
                largeIconBackgroundView.layer.cornerRadius = largeIconBackgroundView.frame.height / 2
                largeIconBackgroundView.layer.masksToBounds = true
                
        UIView.animate(withDuration: 0.3) {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            }
            
            // Position the card off-screen at the bottom (e.g., set the Y constraint to a huge positive number)
            modalCardCenterYConstraint.constant = view.bounds.height
            view.layoutIfNeeded()
        
        dismissButtonView.layer.cornerRadius = dismissButton.frame.height / 2
        dismissButtonView.layer.masksToBounds = true
        
        let iconSize: CGFloat = 12
        let iconConfig = UIImage.SymbolConfiguration(pointSize: iconSize, weight: .medium)
        
        let dismissImage = UIImage(systemName: "xmark", withConfiguration: iconConfig)
        dismissButton.setImage(dismissImage, for: .normal)
                // 3. Populate the UI with data
        setupTapToDismiss()
                configureUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animate both the dimming and the card movement simultaneously
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            // 1. Fade in the background dimming
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            
            // 2. Slide the card up by resetting its Y constraint to center (0)
            self.modalCardCenterYConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }

    // MARK: - UI Configuration
        func configureUI() {
            // We use a guard let here, although the data should be passed, this is a safety measure
            guard let badge = badge else {
                print("ERROR: Badge data is missing for modal configuration.")
                // Handle error, maybe dismiss the VC
                return
            }
            // Set all labels and colors dynamically
            headerLabel.text = modalTitleString ?? "Badge Status"
            
            if !badge.isUnlocked {
                    // Dim the visuals on the modal card if the badge is locked
                    titleLabel.alpha = 0.5
                    subtitleLabel.alpha = 0.5
                    // ... (etc.)
                }
            //titleLabel.text = badge.title
            subtitleLabel.text = badge.subtitle
            largeIconBackgroundView.backgroundColor = badge.color
            
            // Configure the large SF Symbol size and color
            let config = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold)
            largeIconImageView.image = UIImage(systemName: badge.iconName, withConfiguration: config)
            largeIconImageView.tintColor = .white
        }
    
    // BadgeUnlockedModalViewController.swift (Inside the class)

    func setupTapToDismiss() {
        // 1. Create the gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        
        // 2. Add it to the main view of the VC (which covers the entire screen)
        view.addGestureRecognizer(tapGesture)
        
        // 3. Prevent the tap from interfering with the buttons/elements *inside* the card
        tapGesture.cancelsTouchesInView = false
    }
    
    // BadgeUnlockedModalViewController.swift (Inside the class)

    @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
        
        // 1. Get the location of the tap
        let tapLocation = sender.location(in: view)
        
        // 2. Check if the tap location is NOT inside the white modal card
        // You must use the 'modalCardView' outlet here (the white container view)
        if !modalCardView.frame.contains(tapLocation) {
            
            // 3. The tap was outside the card, so dismiss the VC
            dismissTapped(self)
            
        }
    }

        // MARK: - Actions
        
        // Action for the top-corner 'X' button
        @IBAction func dismissTapped(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
}
