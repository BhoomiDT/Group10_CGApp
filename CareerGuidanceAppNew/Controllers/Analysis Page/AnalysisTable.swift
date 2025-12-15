import UIKit

class AnalysisTable: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewAnalysis: UITableView!
    // Removed btnContinue outlet since it's inside the cell now
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    func setupUI() {
        view.backgroundColor = .appBackground
    }
    
    func setupTableView() {
        tableViewAnalysis.backgroundColor = .appBackground
        tableViewAnalysis.dataSource = self
        tableViewAnalysis.delegate = self
        
        // Register your nibs
        tableViewAnalysis.register(UINib(nibName: "AnalysisTableViewCell1", bundle: nil), forCellReuseIdentifier: "cell1")
        tableViewAnalysis.register(UINib(nibName: "AnalysisTableViewCell2", bundle: nil), forCellReuseIdentifier: "cell2")
        tableViewAnalysis.register(UINib(nibName: "AnalysisTableViewCell3", bundle: nil), forCellReuseIdentifier: "cell3")
        
        tableViewAnalysis.separatorStyle = .none
        tableViewAnalysis.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }

    // MARK: - Navigation Logic
    func navigateToHome() {
        let homeStoryboard = UIStoryboard(name: "HomePageProfileNew", bundle: nil)
        
        if let homeVC = homeStoryboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
            
            // Show Roadmap enabled
            homeVC.shouldShowRoadmap = true
            homeVC.shouldUpdateProgress = true
            
            if let windowScene = view.window?.windowScene,
               let window = windowScene.windows.first {
                
                let nav = UINavigationController(rootViewController: homeVC)
                window.rootViewController = nav
                window.makeKeyAndVisible()
                
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        } else {
            print("Error: Could not find HomePageViewController")
        }
    }
    
    // MARK: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        else if section == 1 { return riasecData.count }
        else if section == 2 { return interests.count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        // SECTION 0: The Header Card with the Button
        // SECTION 0: The Header Card
                if section == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! AnalysisTableViewCell1
                    
                    // UI Styling
                    cell.layer.cornerRadius = 16
                    cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                    cell.clipsToBounds = true
                    
                    // *** ASSIGN THE NAVIGATION LOGIC HERE ***
                    cell.onExploreTapped = { [weak self] in
                        // This calls the function in your Controller to go to Home Page
                        self?.navigateToHome()
                    }
                    
                    return cell
                }
        
        // SECTION 1: RIASEC Bars
        if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! AnalysisTableViewCell2
            let data = riasecData[indexPath.row]
            
            cell.labelCategory.text = data.label
            cell.progressBar.progress = data.score
            cell.progressBar.progressTintColor = data.color
            cell.labelScore.text = "\(Int(data.score * 100))%"
            
            let isFirst = indexPath.row == 0
            let isLast  = indexPath.row == riasecData.count - 1
            cell.labelTopConstraint.constant = isFirst ? 16 : 8
            cell.progressBottomConstraint.constant = isLast ? 16 : 8
            
            applyRoundedCorners(for: cell, indexPath: indexPath, numberOfRows: riasecData.count)
            return cell
        }
        
        // SECTION 2: Interests List
        if section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! AnalysisTableViewCell3
            cell.interestLabel.text = interests[indexPath.row]
            
            let isFirst = indexPath.row == 0
            let isLast  = indexPath.row == interests.count - 1
            cell.labelTopConstraint.constant = isFirst ? 16 : 8
            cell.labelBottomConstraint.constant = isLast ? 16 : 8
            
            applyRoundedCorners(for: cell, indexPath: indexPath, numberOfRows: interests.count)
            return cell
        }
        
        return UITableViewCell()
    }
    
    // ... (Keep existing Helper functions below: applyRoundedCorners, viewForHeader, etc.) ...
    
    private func applyRoundedCorners(for cell: UITableViewCell, indexPath: IndexPath, numberOfRows: Int) {
        if numberOfRows == 1 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else if indexPath.row == 0 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == numberOfRows - 1 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.cornerRadius = 0
        }
        cell.clipsToBounds = true
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        let headerView = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .label
        if section == 1 { label.text = "RIASEC Analysis" }
        else { label.text = "Other Analysis" }
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5)
        ])
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 45
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 2 ? 0 : 12
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .clear
        return footer
    }
}
