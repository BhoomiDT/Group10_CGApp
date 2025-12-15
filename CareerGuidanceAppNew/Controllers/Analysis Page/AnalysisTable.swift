import UIKit

class AnalysisTable: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewAnalysis: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        setupTableView()
    }
    
    func setupTableView() {
        
        tableViewAnalysis.backgroundColor = .appBackground
        
        ["AnalysisTableViewCell1": "cell1", "AnalysisTableViewCell2": "cell2", "AnalysisTableViewCell3": "cell3"].forEach {
            tableViewAnalysis.register(UINib(nibName: $0.key, bundle: nil), forCellReuseIdentifier: $0.value)
        }
    }

    func navigateToHome() {
        let sb = UIStoryboard(name: "HomePageProfileNew", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController,
           let window = view.window?.windowScene?.windows.first {
            window.rootViewController = UINavigationController(rootViewController: vc)
            window.makeKeyAndVisible()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        return section == 1 ? riasecData.count : interests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        let configureCellBackground: (UITableViewCell) -> Void = { cell in
            cell.backgroundColor = .white
            cell.contentView.backgroundColor = .white
        }

        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! AnalysisTableViewCell1
            configureCellBackground(cell)
            
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.clipsToBounds = true
            cell.onExploreTapped = { [weak self] in self?.navigateToHome() }
            return cell
        }
        
        if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! AnalysisTableViewCell2
            configureCellBackground(cell)
            
            let data = riasecData[indexPath.row]
            cell.labelCategory.text = data.label
            cell.progressBar.progress = data.score
            cell.progressBar.progressTintColor = data.color
            cell.labelScore.text = "\(Int(data.score * 100))%"
            
            cell.labelTopConstraint.constant = indexPath.row == 0 ? 16 : 8
            cell.progressBottomConstraint.constant = indexPath.row == riasecData.count - 1 ? 16 : 8
            
            applyRoundedCorners(for: cell, indexPath: indexPath, numberOfRows: riasecData.count)
            return cell
        }
        
        if section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! AnalysisTableViewCell3
            configureCellBackground(cell)
            
            cell.interestLabel.text = interests[indexPath.row]
            
            cell.labelTopConstraint.constant = indexPath.row == 0 ? 16 : 8
            cell.labelBottomConstraint.constant = indexPath.row == interests.count - 1 ? 16 : 8
            
            applyRoundedCorners(for: cell, indexPath: indexPath, numberOfRows: interests.count)
            return cell
        }
        return UITableViewCell()
    }
    
    private func applyRoundedCorners(for cell: UITableViewCell, indexPath: IndexPath, numberOfRows: Int) {
        cell.layer.cornerRadius = 16
        cell.clipsToBounds = true
        if numberOfRows == 1 {
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else if indexPath.row == 0 {
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == numberOfRows - 1 {
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.cornerRadius = 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        let headerView = UIView()
        headerView.backgroundColor = .clear // Ensure header is transparent to show app background
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .label
        label.text = section == 1 ? "RIASEC Analysis" : "Other Analysis"
        
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5)
        ])
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { section == 0 ? 0 : 45 }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { section == 2 ? 0 : 12 }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }
}
