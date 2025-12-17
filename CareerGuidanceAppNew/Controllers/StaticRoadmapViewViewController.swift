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
        loadRoadmapData()
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
    
    func loadRoadmapData() {
        guard let selectedRoadmap = staticRoadmaps.first else { return }

        self.roadmap = selectedRoadmap
        self.milestoneList = selectedRoadmap.milestones
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
            iconColor: item.iconColor ?? .label,
            bgColor: item.iconBackgroundColor ?? .systemGray5
        )

        return cell
    }
}
