import UIKit

class SkillsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Data
    private var selected: [String] = [
        "Cloud Computing",
        "Flask",
    ]

    private var suggestions: [String] = [
        "NLP", "Objective-C", "PHP", "PLSQL", "PySpark",
        "PyTorch", "Python", "React Native", "SQL Database",
        "Django", "Kotlin"
    ]

    private var filteredSuggestions: [String] = []
    private var isFiltering: Bool {
        let t = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return !t.isEmpty
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupTableViewAndSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // Enable Large Titles (Title starts big on left, scrolls to center)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // OPTIONAL: If you want to prevent swiping back as well, uncomment this:
        // navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - Setup UI
    private func setupTableViewAndSearch() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(named: "systemGroupedBackground") ?? .systemGroupedBackground
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .automatic
        }
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }

        // Search Container
        searchContainerView.layer.cornerRadius = 28
        searchContainerView.layer.masksToBounds = false
        searchContainerView.layer.shadowColor = UIColor.black.cgColor
        searchContainerView.layer.shadowOpacity = 0.06
        searchContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        searchContainerView.layer.shadowRadius = 8
        searchContainerView.backgroundColor = .clear

        // Search Bar
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = .clear

        view.layoutIfNeeded()
        tableView.contentInset.bottom = searchContainerView.frame.height + 12
    }
    
    private func setupNavigationItems() {
        self.title = "Technical Skills"
        
        // FIX: This line hides the chevron (System Back Button)
        self.navigationItem.hidesBackButton = true
        
        // Done Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        self.navigationItem.rightBarButtonItem = doneBtn
    }

    @objc func doneTapped() {
        OnboardingManager.shared.saveTechSkills(self.selected)
        
        if let nextIntro = storyboard?.instantiateViewController(withIdentifier: "IntroVC") as? onboardingSectionIntroViewController {
            nextIntro.sectionIndex = 2
            navigationController?.pushViewController(nextIntro, animated: true)
        }
    }

    // MARK: - Helpers
    private func suggestionsArray() -> [String] {
        return isFiltering ? filteredSuggestions : suggestions
    }

    private func indexPath(forSelectedCell cell: SelectedSkillCell) -> IndexPath? {
        if let text = cell.titleLabel.text, let row = selected.firstIndex(of: text) {
            return IndexPath(row: row, section: 0)
        }
        return nil
    }

    private func indexPath(forSuggestionCell cell: SuggestionSkillCell) -> IndexPath? {
        let source = suggestionsArray()
        if let text = cell.titleLabel.text, let row = source.firstIndex(of: text) {
            return IndexPath(row: row, section: 1)
        }
        return nil
    }
}

// MARK: - Extensions: DataSource
extension SkillsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? selected.count : suggestionsArray().count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Selected" : "Suggestions"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedSkillCell", for: indexPath) as? SelectedSkillCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = selected[indexPath.row]
            cell.delegate = self
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            cell.backgroundColor = .systemBackground
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionSkillCell", for: indexPath) as? SuggestionSkillCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = suggestionsArray()[indexPath.row]
            cell.delegate = self
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            cell.backgroundColor = .systemBackground
            return cell
        }
    }
}

// MARK: - Extensions: Delegate
extension SkillsViewController: SelectedSkillCellDelegate, SuggestionSkillCellDelegate {
    func selectedCellDidTapRemove(_ cell: SelectedSkillCell) {
        guard let ip = indexPath(forSelectedCell: cell) else { return }
        let item = selected.remove(at: ip.row)
        suggestions.insert(item, at: 0)

        tableView.beginUpdates()
        tableView.deleteRows(at: [ip], with: .automatic)
        tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        tableView.endUpdates()

        if isFiltering { filterSuggestions(with: searchBar.text ?? "") }
    }

    func suggestionCellDidTapAdd(_ cell: SuggestionSkillCell) {
        guard let ip = indexPath(forSuggestionCell: cell) else { return }
        let item = suggestionsArray()[ip.row]

        if let realIndex = suggestions.firstIndex(of: item) {
            suggestions.remove(at: realIndex)
        }
        selected.insert(item, at: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.deleteRows(at: [ip], with: .automatic)
        tableView.endUpdates()

        if isFiltering { filterSuggestions(with: searchBar.text ?? "") }
    }
}

// MARK: - Extensions: TableView Selection
extension SkillsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let item = selected[indexPath.row]
            selected.remove(at: indexPath.row)
            suggestions.insert(item, at: 0)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            tableView.endUpdates()
            if isFiltering { filterSuggestions(with: searchBar.text ?? "") }
        } else {
            let item = suggestionsArray()[indexPath.row]
            if let real = suggestions.firstIndex(of: item) { suggestions.remove(at: real) }
            selected.insert(item, at: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            if isFiltering { filterSuggestions(with: searchBar.text ?? "") }
        }
    }
}

// MARK: - Extensions: Search
extension SkillsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterSuggestions(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredSuggestions.removeAll()
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }

    private func filterSuggestions(with text: String) {
        let q = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if q.isEmpty {
            filteredSuggestions = []
        } else {
            filteredSuggestions = suggestions.filter { $0.lowercased().contains(q) }
        }
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}
