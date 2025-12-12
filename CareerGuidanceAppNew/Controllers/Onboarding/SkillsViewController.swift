//
//  SkillsViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//
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
        "NLP",
        "Objective-C",
        "PHP",
        "PLSQL",
        "PySpark",
        "PyTorch",
        "Python",
        "React Native",
        "SQL Database",
        "Django",
        "Kotlin"
    ]

    private var filteredSuggestions: [String] = []
    private var isFiltering: Bool {
        let t = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return !t.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        // Register nibs if you created separate xib or rely on storyboard prototype cells (skip registration).
        // tableView.register(UINib(nibName: "SelectedSkillCell", bundle: nil), forCellReuseIdentifier: "SelectedSkillCell")
        // tableView.register(UINib(nibName: "SuggestionSkillCell", bundle: nil), forCellReuseIdentifier: "SuggestionSkillCell")

        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(hex: "F2F2F7")
        
        if #available(iOS 11.0, *) {
                tableView.contentInsetAdjustmentBehavior = .automatic
            }
        if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0
            }

        // round floating search container and add shadow
        searchContainerView.layer.cornerRadius = 28
        searchContainerView.layer.masksToBounds = false
        searchContainerView.layer.shadowColor = UIColor.black.cgColor
        searchContainerView.layer.shadowOpacity = 0.06
        searchContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        searchContainerView.layer.shadowRadius = 8
        
        // make container a shadow host only (no visible fill)
            searchContainerView.backgroundColor = .clear
            searchContainerView.layer.masksToBounds = false
            searchContainerView.layer.shadowColor = UIColor.black.cgColor
            searchContainerView.layer.shadowOpacity = 0.06
            searchContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
            searchContainerView.layer.shadowRadius = 8

            // remove default search bar chrome so it doesn't draw that rectangle
        searchBar.backgroundImage = UIImage()       // removes bar background
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = .clear

        // ensure rows can scroll above the pill
        view.layoutIfNeeded()
        tableView.contentInset.bottom = searchContainerView.frame.height + 12
    }

    private func suggestionsArray() -> [String] {
        return isFiltering ? filteredSuggestions : suggestions
    }

    // helper to index path of a given cell's skill
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

// MARK: - Data Source
extension SkillsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 2 } // Selected, Suggestions

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? selected.count : suggestionsArray().count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Selected" : "Suggestions"
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedSkillCell", for: indexPath) as? SelectedSkillCell else {
                fatalError("SelectedSkillCell not registered or wrong class")
            }
            cell.titleLabel.text = selected[indexPath.row]
            cell.delegate = self
            // left button style done in cell awakeFromNib
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            cell.backgroundColor = .systemBackground
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionSkillCell", for: indexPath) as? SuggestionSkillCell else {
                fatalError("SuggestionSkillCell not registered or wrong class")
            }
            cell.titleLabel.text = suggestionsArray()[indexPath.row]
            cell.delegate = self
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            cell.backgroundColor = .systemBackground
            return cell
        }
    }
}

// MARK: - Delegate: handle taps forwarded from cells
extension SkillsViewController: SelectedSkillCellDelegate, SuggestionSkillCellDelegate {
    func selectedCellDidTapRemove(_ cell: SelectedSkillCell) {
        guard let ip = indexPath(forSelectedCell: cell) else { return }
        // move from selected -> suggestions (insert at top)
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
        // get item (from filtered or base)
        let item = suggestionsArray()[ip.row]

        // remove from base suggestions (find real index)
        if let realIndex = suggestions.firstIndex(of: item) {
            suggestions.remove(at: realIndex)
        }
        // add to selected top
        selected.insert(item, at: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.deleteRows(at: [ip], with: .automatic)
        tableView.endUpdates()

        if isFiltering { filterSuggestions(with: searchBar.text ?? "") }
    }
}

// MARK: - UITableViewDelegate (optional taps)
extension SkillsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // same as pressing remove
            let item = selected[indexPath.row]
            // move
            selected.remove(at: indexPath.row)
            suggestions.insert(item, at: 0)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            tableView.endUpdates()
            if isFiltering { filterSuggestions(with: searchBar.text ?? "") }
        } else {
            // add
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

// MARK: - Search
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
