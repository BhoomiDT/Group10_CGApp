import UIKit

class JourneyViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Data
    private var sections: [JourneySection] = JourneyData.milestones   // default tab

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        tableView.backgroundColor = .systemGroupedBackground
        setupUI()
        setupTableView()
    }

    // MARK: - Setup
    private func setupUI() {
        titleLabel.text = "My Journey"

        // In case titles are not set in storyboard
        if segmentedControl.numberOfSegments == 2 {
            segmentedControl.setTitle("Milestone History", forSegmentAt: 0)
            segmentedControl.setTitle("Learned Skills", forSegmentAt: 1)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.label
        ], for: .normal)

        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.white
        ], for: .selected)
    }

    private func setupTableView() {
        // Register the XIB-based cell
        let nib = UINib(nibName: "JourneyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "JourneyTableViewCell")

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.sectionHeaderTopPadding = 8

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = .systemGroupedBackground
            view.backgroundColor = .systemGroupedBackground

    }

    // MARK: - Actions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sections = JourneyData.milestones
        } else {
            sections = JourneyData.skills
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension JourneyViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "JourneyTableViewCell",
            for: indexPath
        ) as? JourneyTableViewCell else {
            return UITableViewCell()
        }

        let item = sections[indexPath.section].items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension JourneyViewController: UITableViewDelegate {
    // later you can add didSelectRowAt if needed
}
