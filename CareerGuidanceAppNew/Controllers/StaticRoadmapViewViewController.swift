//
//  StaticRoadmapViewViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 08/12/25.
//

import UIKit

class StaticRoadmapViewViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var roadmap: StaticRoadmap?
    var milestoneList: [Milestone] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEW DID LOAD WORKED")
        loadRoadmapJSON()
        setupTable()
        setupHeader()
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()

           if let header = tableView.tableHeaderView {
               header.setNeedsLayout()
               header.layoutIfNeeded()

               let height = header.systemLayoutSizeFitting(
                   CGSize(width: tableView.bounds.width,
                          height: UIView.layoutFittingCompressedSize.height),
                   withHorizontalFittingPriority: .required,
                   verticalFittingPriority: .fittingSizeLevel
               ).height

               if header.frame.height != height {
                   var frame = header.frame
                   frame.size.height = height
                   header.frame = frame
                   tableView.tableHeaderView = header
               }
           }
       }
    
    func setupHeader() {
        let nib = UINib(nibName: "StaticHeaderView", bundle: nil)
        let header = nib.instantiate(withOwner: nil, options: nil).first as! StaticHeaderView

        guard let roadmap = roadmap else { return }

        header.bodyLabel.text = roadmap.description

        // Auto-size
        header.layoutIfNeeded()
        tableView.tableHeaderView = header.sizedForTableHeader()
    }
    
    func loadRoadmapJSON() {
        print("Entered load json")
        guard let url = Bundle.main.url(forResource: "StaticRoadmapData", withExtension: "json") else {
            print("ERROR: StaticRoadmapData.json not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(StaticRoadmap.self, from: data)
            self.roadmap = decoded
            self.milestoneList = decoded.milestones
        } catch {
            print("JSON Decode Error:", error)
        }
        print("Leaving load json")
    }
    
    func setupTable() {
        print("setupTable CALLED")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(
            UINib(nibName: "MilestonesTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MilestonesTableViewCell"
        )
    }
}
extension StaticRoadmapViewViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Rows count =", milestoneList.count)
        return milestoneList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Identifier asked:", "MilestonesTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MilestonesTableViewCell", for: indexPath) as! MilestonesTableViewCell
        let item = milestoneList[indexPath.row]

        cell.configure(
            title: item.title,
            subtitle: item.subtitle,
            iconName: item.iconName,
            iconColor: UIColor(hex: item.iconColor) ?? .label,
            bgColor: UIColor(hex: item.iconBackgroundColor) ?? .systemGray5
        )

        return cell
    }
}
