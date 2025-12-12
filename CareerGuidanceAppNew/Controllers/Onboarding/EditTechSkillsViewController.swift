import UIKit

class EditTechSkillsViewController: UIViewController {

    // connect these in storyboard
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var bottomTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topTableHeightConstraint: NSLayoutConstraint!

    
    private let estimatedRowHeight: CGFloat = 56.0
    private let topTableMaxHeight: CGFloat = 360.0    // adjust to taste
    private let topTableMinHeight: CGFloat = 0.0      // when no selected items -> hide
    // Data
    var selectedSkills: [String] = []
    var allSkills: [String] = [
        "Python", "Objective-C","TypeScript", "React Native",
        "Flask", "Spring Boot", "NLP", "Cloud Computing",
        "Tensorflow", "SQL Database", "Pandas", "Perl", "PHP",
        "PLSQL", "PyTorch", "PySpark"
    ]

    // filtered suggestions shown in bottom table (respecting search)
    var filteredSkills: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove any already selected items from suggestions
        allSkills.removeAll { selectedSkills.contains($0) }
        allSkills.sort()
        filteredSkills = allSkills

        // delegates & data sources
        topTableView.dataSource = self
        topTableView.delegate = self
        bottomTableView.dataSource = self
        bottomTableView.delegate = self
        searchBar.delegate = self

        // automatic height
        topTableView.rowHeight = UITableView.automaticDimension
        bottomTableView.rowHeight = UITableView.automaticDimension
        topTableView.estimatedRowHeight = 56
        bottomTableView.estimatedRowHeight = 56

        // Optional: remove extra separators
        topTableView.tableFooterView = UIView()
        bottomTableView.tableFooterView = UIView()
        
        topTableView.rowHeight = UITableView.automaticDimension
            topTableView.estimatedRowHeight = estimatedRowHeight
            // initial sizing
            updateTopTableHeight(animated: false)
    }

    // MARK: - Helpers

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

        // Remove from allSkills (master) and filtered list
        if let masterIndex = allSkills.firstIndex(of: skill) {
            allSkills.remove(at: masterIndex)
        }
        // Remove from filteredSkills too (updateFiltering will refresh)
        // Add to selected
        selectedSkills.append(skill)

        // Update filtered list and tables with animation
        updateFiltering(text: searchBar.text ?? "")
        let newIndexPath = IndexPath(row: selectedSkills.count - 1, section: 0)
        topTableView.insertRows(at: [newIndexPath], with: .automatic)
        
        //adjusting height
        self.updateTopTableHeight()
    }

    func removeSkillFromSelected(at index: Int) {
        guard index >= 0 && index < selectedSkills.count else { return }
        let removed = selectedSkills.remove(at: index)
        // Add back to suggestions, keep sorted
        allSkills.append(removed)
        allSkills.sort()
        updateFiltering(text: searchBar.text ?? "")

        // animate deletion in selected table
        let indexPath = IndexPath(row: index, section: 0)
        topTableView.deleteRows(at: [indexPath], with: .automatic)
        
        //adjusting height
        self.updateTopTableHeight()
    }
    
    func updateTopTableHeight(animated: Bool = true) {
        // Force layout to ensure contentSize is updated
        topTableView.layoutIfNeeded()

        // Calculate target height from contentSize
        let contentHeight = topTableView.contentSize.height
        // optionally add small padding for separators / safe area
        let targetHeight = min(max(contentHeight, topTableMinHeight), topTableMaxHeight)

        // Enable scrolling on the top table if content exceeds max
        topTableView.isScrollEnabled = contentHeight > topTableMaxHeight

        // If height hasn't changed, skip
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

// MARK: - Table datasource & delegate
extension EditTechSkillsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == topTableView ? selectedSkills.count : filteredSkills.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == topTableView {
            // Selected cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "selected_cell", for: indexPath) as? SelectedTableViewCell else {
                fatalError("selected_cell identifier not set or class mismatch")
            }
            let skill = selectedSkills[indexPath.row]
            cell.skillLabel.text = skill

            // Configure minus button
            let minusImage = UIImage(systemName: "minus.circle.fill")
            cell.minusButton.setImage(minusImage, for: .normal)
            cell.minusButton.tintColor = .systemRed

            // tag to identify row and add target
            cell.minusButton.tag = indexPath.row
            cell.minusButton.addTarget(self, action: #selector(minusButtonTapped(_:)), for: .touchUpInside)

            cell.selectionStyle = .none
            return cell

        } else {
            // Suggested cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "suggested_cell", for: indexPath) as? SuggestedTableViewCell else {
                fatalError("suggested_cell identifier not set or class mismatch")
            }
            let skill = filteredSkills[indexPath.row]
            cell.skillLabel.text = skill

            // Configure plus button
            let plusImage = UIImage(systemName: "plus.circle.fill")
            cell.plusButton.setImage(plusImage, for: .normal)
            cell.plusButton.tintColor = .systemBlue

            cell.plusButton.tag = indexPath.row
            cell.plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)

            cell.selectionStyle = .none
            return cell
        }
    }

    // Allow tapping the row to behave like pressing the button
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == bottomTableView {
            addSkillFromSuggestions(at: indexPath.row)
        } else {
            removeSkillFromSelected(at: indexPath.row)
        }
    }

    // Optional: swipe-to-delete for top table
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if tableView == topTableView && editingStyle == .delete {
            removeSkillFromSelected(at: indexPath.row)
        }
    }

    // section headers
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableView == topTableView ? "Selected" : "Suggestions"
    }
}

// MARK: - Button actions
extension EditTechSkillsViewController {
    @objc func minusButtonTapped(_ sender: UIButton) {
        let row = sender.tag
        removeSkillFromSelected(at: row)
    }

    @objc func plusButtonTapped(_ sender: UIButton) {
        let row = sender.tag
        addSkillFromSuggestions(at: row)
    }
}

// MARK: - SearchBar
extension EditTechSkillsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFiltering(text: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
