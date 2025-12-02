//
//  LeaderboardViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 28/11/25.
//

import UIKit

class LeaderboardViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var firstPlaceImageView: UIImageView!
    @IBOutlet weak var firstPlaceNameLabel: UILabel!
    @IBOutlet weak var firstPlaceXPLabel: UILabel!
    
    
    @IBOutlet weak var secondPlaceImageView: UIImageView!
    @IBOutlet weak var secondPlaceNameLabel: UILabel!
    @IBOutlet weak var secondPlaceXPLabel: UILabel!
    
    
    @IBOutlet weak var thirdPlaceImageView: UIImageView!
    @IBOutlet weak var thirdPlaceNameLabel: UILabel!
    @IBOutlet weak var thirdPlaceXPLabel: UILabel!
    
    @IBOutlet weak var crownImageView: UIImageView!
    
    var currentData: [LeaderboardEntry] = dailyLeaderboard

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.layer.cornerRadius = 20
        tableView.clipsToBounds = true
        segmentedControl.selectedSegmentIndex = 0
        
        updateUI()
        configureSegmentedControlAppearance()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        
        // 1. Safely extract the data for the Top 3
        let firstPlace = currentData.count > 0 ? currentData[0] : nil
        let secondPlace = currentData.count > 1 ? currentData[1] : nil
        let thirdPlace = currentData.count > 2 ? currentData[2] : nil

        // 2. Populate 1st Place (Jessica)
        firstPlaceNameLabel.text = firstPlace?.name ?? "N/A"
        firstPlaceXPLabel.text = "\(firstPlace?.xp ?? 0) XP"
        configureProfileImage(imageView: firstPlaceImageView, entry: firstPlace)

        // 3. Populate 2nd Place (Walter)
        secondPlaceNameLabel.text = secondPlace?.name ?? "N/A"
        secondPlaceXPLabel.text = "\(secondPlace?.xp ?? 0) XP"
        configureProfileImage(imageView: secondPlaceImageView, entry: secondPlace)

        // 4. Populate 3rd Place (Jane)
        thirdPlaceNameLabel.text = thirdPlace?.name ?? "N/A"
        thirdPlaceXPLabel.text = "\(thirdPlace?.xp ?? 0) XP"
        configureProfileImage(imageView: thirdPlaceImageView, entry: thirdPlace)

        let shouldShowCrown = firstPlace != nil
        crownImageView.isHidden = !shouldShowCrown
        // 5. Reload Table View
        tableView.reloadData()
    }
    
    func configureSegmentedControlAppearance() {
        // 1. Attributes for the SELECTED segment (e.g., "Daily")
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            // Set the text color to white
            .foregroundColor: UIColor.white,
            // Optional: Make the text slightly bolder or larger when selected
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]

        // Apply the attributes to the .selected state
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)

        // 2. Attributes for the NORMAL (unselected) segments
        let normalAttributes: [NSAttributedString.Key: Any] = [
            // Set the text color for unselected segments (e.g., light gray or dark gray)
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]

        // Apply the attributes to the .normal state
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        // NOTE: This assumes your segmentedControl is an IBOutlet connected in your ViewController.
    }
    
    @IBAction func segmentdControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                currentData = dailyLeaderboard
            case 1:
                currentData = weeklyLeaderboard // Use your weekly array
            case 2:
                currentData = monthlyLeaderboard // Use your monthly array
            default:
                break
            }
            
            // Refresh all UI elements with the new data
            updateUI()
    }
    
    func configureProfileImage(imageView: UIImageView, entry: LeaderboardEntry?) {
        guard let entry = entry else {
            // Fallback for missing data
            imageView.image = UIImage(systemName: "person.circle.fill")
            imageView.layer.borderWidth = 0
            return
        }

        // Load Image (Placeholder logic remains the same)
        if let imageName = entry.imageName, let image = UIImage(named: imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "person.circle.fill")
        }

        // Set masksToBounds here if you didn't do it in the Storyboard Identity Inspector
        imageView.layer.masksToBounds = true
        
        var borderColor: UIColor? = nil
        var borderWidth: CGFloat = 0.0

        // --- Define Colors and Border Thickness based on Rank ---
        switch entry.rank {
        case 1:
            // Gold (Thickest Border)
            borderColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0) // Bright Gold/Yellow
            borderWidth = 6.0
        case 2:
            // Silver (Medium Border)
            borderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0) // Gray/Silver
            borderWidth = 5.0
        case 3:
            // Bronze (Thinnest Border)
            borderColor = UIColor(red: 0.8, green: 0.5, blue: 0.2, alpha: 1.0) // Brown/Bronze
            borderWidth = 4.0
        default:
            // No Border for ranks 4 and below
            borderColor = nil
            borderWidth = 0.0
        }

        // --- Apply the results ---
        if let color = borderColor {
            imageView.layer.borderColor = color.cgColor
            imageView.layer.borderWidth = borderWidth
        } else {
            imageView.layer.borderWidth = 0.0
        }
    }
    
}

extension LeaderboardViewController: UITableViewDataSource {
    
    // A. Define the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We subtract the 3 users already displayed in the Top 3 section
        return max(0, currentData.count - 3)
    }
    
    // B. Populate each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Ensure you use the exact same Identifier set in the Storyboard
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as? LeaderboardCell else {
            return UITableViewCell()
        }
        
        // Row 0 in the list corresponds to the 4th element (index 3) in the data array
        let dataIndex = indexPath.row + 3
        
        guard dataIndex < currentData.count else {
            return UITableViewCell() // Should not happen if data is well-formed
        }
        
        let entry = currentData[dataIndex]
        
        // Set the label values using the custom cell's outlets
        cell.rankLabel.text = "\(entry.rank)"
        cell.nameLabel.text = entry.name
        cell.xpLabel.text = "\(entry.xp) XP"
        
        return cell
    }
}
