//
//  BadgesViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 08/12/25.
//

import UIKit

class BadgesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var badgesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "BadgeCell", bundle: nil)
            badgesCollectionView.register(nib, forCellWithReuseIdentifier: "BadgeCell")

        
            // Set the delegate and data source
            badgesCollectionView.dataSource = self
        badgesCollectionView.delegate = self
        // Do any additional setup after loading the view.
        badgesCollectionView.layoutIfNeeded()
            
            // 2. Set the Height Constraint to the full content size
            let contentHeight = badgesCollectionView.contentSize.height
            collectionViewHeightConstraint.constant = contentHeight
            
            // 3. Optional: Re-layout the view to apply the change
            view.layoutIfNeeded()
            
            // Set the height constraint to the calculated content size
            collectionViewHeightConstraint.constant = badgesCollectionView.contentSize.height
    }
    
    // BadgesViewController.swift (Inside the class)

    func presentBadgeModal(with badge: Badge) {
        
        // 1. Get the Storyboard
        let storyboard = UIStoryboard(name: "Badges", bundle: nil)
        
        
        
        // 2. Instantiate the VC using the verified ID
        guard let modalVC = storyboard.instantiateViewController(withIdentifier: "BadgeUnlockedModalVC") as? BadgeUnlockedModalViewController else {
            // If this fails, we know the Storyboard ID or Custom Class is wrong.
            print("Fatal Error: Storyboard ID 'BadgeUnlockedModalVC' check failed.")
            return
        }
        
        let screenTitle: String
            if badge.isUnlocked {
                screenTitle = "Unlocked New Badge"
            } else {
                screenTitle = "Not Yet Unlocked" // <--- The desired title for locked badges
            }
        
        // 3. Pass the data
        modalVC.badge = badge
        modalVC.modalTitleString = screenTitle
        
        // 4. Present
        //modalVC.modalTransitionStyle = .crossDissolve
        modalVC.modalPresentationStyle = .overFullScreen // OR .overCurrentContext
        modalVC.modalTransitionStyle = .crossDissolve // <-- This is the transition we want
        present(modalVC, animated: true, completion: nil)
    }
    
    // BadgesViewController.swift (Inside UICollectionViewDelegate extension)

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the badge data
        let selectedBadge = dataSource[indexPath.section].badges[indexPath.row]
        
        // Trigger presentation
        presentBadgeModal(with: selectedBadge)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            
            // We need 16 (top) + ~20 (label height) + 8 (bottom) = 44 points minimum.
            // Let's use 50 points to be safe.
        let headerHeight: CGFloat = 60
            
        return CGSize(width: collectionView.bounds.width, height: headerHeight)
    }
    
    // BadgesViewController.swift (Inside the extension)

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // Check if we are asking for a header
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeaderView else {
                fatalError("Could not dequeue SectionHeaderView")
            }
            
            // Use the title from your data source
            header.titleLabel.text = dataSource[indexPath.section].title
            return header
        }
        return UICollectionReusableView()
    }
    

    // BadgesViewController.swift

    // Assign the data to a local variable
    let dataSource = allBadgeSections

    // 1. Number of sections (e.g., Featured and Weekly Achievement)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }

    // 2. Number of items in each section (the number of badges)
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].badges.count
    }

    // 3. Dequeue and configure the cell
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Use the custom cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadgeCell", for: indexPath) as? BadgeCell else {
            fatalError("Could not dequeue BadgeCell")
        }
        
        // Get the correct badge data
        let section = dataSource[indexPath.section]
        let badge = section.badges[indexPath.row]
        
        // Configure the cell with the badge data
        cell.configure(with: badge)
        
        return cell
    }
    // BadgesViewController.swift (Inside the UICollectionViewDelegate extension)

    
    // BadgesViewController.swift (Inside the class)
}
extension BadgesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        // Use the hardcoded spacing value from the Storyboard (16 pts)
        let totalSpacing = flowLayout.minimumInteritemSpacing * (columns - 1)
        let availableWidth = collectionView.bounds.width - totalSpacing
        
        let widthPerItem = floor(availableWidth / columns)
        
        // Return 1:1 aspect ratio
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
