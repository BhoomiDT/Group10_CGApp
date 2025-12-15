import UIKit

class EditTechSkillsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var bottomTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topTableHeightConstraint: NSLayoutConstraint!

    private let estimatedRowHeight: CGFloat = 56.0
    private let topTableMaxHeight: CGFloat = 360.0
    private let topTableMinHeight: CGFloat = 0.0
    
    // Data
    var selectedSkills: [String] = []
    var allSkills: [String] = [
        "Python", "Objective-C", "TypeScript", "React Native",
        "Flask", "Spring Boot", "NLP", "Cloud Computing",
        "Tensorflow", "SQL Database", "Pandas", "Perl", "PHP",
        "PLSQL", "PyTorch", "PySpark"
    ]

    var filteredSkills: [String] = []

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setupDoneButton()

        // Remove any already selected items from suggestions
        allSkills.removeAll { selectedSkills.contains($0) }
        allSkills.sort()
        filteredSkills = allSkills

        // Delegates & Data Sources
        topTableView.dataSource = self
        topTableView.delegate = self
        bottomTableView.dataSource = self
        bottomTableView.delegate = self
        searchBar.delegate = self

        // Automatic Height
        topTableView.rowHeight = UITableView.automaticDimension
        bottomTableView.rowHeight = UITableView.automaticDimension
        topTableView.estimatedRowHeight = 56
        bottomTableView.estimatedRowHeight = 56

        // Footer cleanup
        topTableView.tableFooterView = UIView()
        bottomTableView.tableFooterView = UIView()
        
        updateTopTableHeight(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Setup UI
    
    private func setupDoneButton() {
        title = "Technical Skills"
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneBtn
    }

    // MARK: - Actions
    
    @objc func doneButtonTapped() {
            // 1. Save selected skills
            OnboardingManager.shared.saveTechSkills(self.selectedSkills)
            
            // 2. Navigate to Section 2 (Psychometric - Practical Thinking)
            if let nextIntro = storyboard?.instantiateViewController(withIdentifier: "IntroVC") as? onboardingSectionIntroViewController {
                
                // IMPORTANT: Set index to 2 so it loads "Practical & Analytical Thinking"
                nextIntro.sectionIndex = 2
                
                navigationController?.pushViewController(nextIntro, animated: true)
            } else {
                print("Error: Could not find 'IntroVC'")
            }
        }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        doneButtonTapped()
    }

    @IBAction func skipButtonTapped(_ sender: UIButton) {
        // Navigate to Home Page WITHOUT Roadmap, but WITH Progress update
        if let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
            
            homeVC.shouldShowRoadmap = false
            homeVC.shouldUpdateProgress = true
            
            // Set as root to prevent going back
            navigationController?.setViewControllers([homeVC], animated: true)
        }
    }

    // MARK: - Helpers & Filtering

    func updateFiltering(text: String) {
        let q = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if q.isEmpty {
            filteredSkills = allSkills
        } else {
            filteredSkills = allSkills.filter { $0.range(of: q, options: .caseInsensitive) != nil }
        }
        bottomTableView.reloadData()
    }

    func addSkillFromSuggestions(at filteredIndex: Int) {
        guard filteredIndex >= 0 && filteredIndex < filteredSkills.count else { return }
        let skill = filteredSkills[filteredIndex]

        if let masterIndex = allSkills.firstIndex(of: skill) {
            allSkills.remove(at: masterIndex)
        }
        selectedSkills.append(skill)

        updateFiltering(text: searchBar.text ?? "")
        let newIndexPath = IndexPath(row: selectedSkills.count - 1, section: 0)
        topTableView.insertRows(at: [newIndexPath], with: .automatic)
        
        self.updateTopTableHeight()
    }

    func removeSkillFromSelected(at index: Int) {
        guard index >= 0 && index < selectedSkills.count else { return }
        let removed = selectedSkills.remove(at: index)
        allSkills.append(removed)
        allSkills.sort()
        updateFiltering(text: searchBar.text ?? "")

        let indexPath = IndexPath(row: index, section: 0)
        topTableView.deleteRows(at: [indexPath], with: .automatic)
        
        self.updateTopTableHeight()
    }
    
    func updateTopTableHeight(animated: Bool = true) {
        topTableView.layoutIfNeeded()

        let contentHeight = topTableView.contentSize.height
        let targetHeight = min(max(contentHeight, topTableMinHeight), topTableMaxHeight)

        topTableView.isScrollEnabled = contentHeight > topTableMaxHeight

        guard abs(topTableHeightConstraint.constant - targetHeight) > 0.5 else { return }

        topTableHeightConstraint.constant = targetHeight

        if animated {
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        } else {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - TableView DataSource & Delegate
extension EditTechSkillsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == topTableView ? selectedSkills.count : filteredSkills.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == topTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "selected_cell", for: indexPath) as? SelectedTableViewCell else {
                return UITableViewCell()
            }
            cell.skillLabel.text = selectedSkills[indexPath.row]
            cell.minusButton.tag = indexPath.row
            cell.minusButton.addTarget(self, action: #selector(minusButtonTapped(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell

        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "suggested_cell", for: indexPath) as? SuggestedTableViewCell else {
                return UITableViewCell()
            }
            cell.skillLabel.text = filteredSkills[indexPath.row]
            cell.plusButton.tag = indexPath.row
            cell.plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == bottomTableView {
            addSkillFromSuggestions(at: indexPath.row)
        } else {
            removeSkillFromSelected(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableView == topTableView ? "Selected" : "Suggestions"
    }
}

// MARK: - Button Actions Extension
extension EditTechSkillsViewController {
    @objc func minusButtonTapped(_ sender: UIButton) {
        removeSkillFromSelected(at: sender.tag)
    }

    @objc func plusButtonTapped(_ sender: UIButton) {
        addSkillFromSuggestions(at: sender.tag)
    }
}

// MARK: - SearchBar Delegate
extension EditTechSkillsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFiltering(text: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
