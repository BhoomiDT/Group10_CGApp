//
//  StrengthsTableContainerCell.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 11/12/25.
//

import UIKit

class StrengthsTableContainerCell: UICollectionViewCell {

    @IBOutlet weak var tableView: UITableView!

    private var strengths: [StrengthItem] = []

    override func awakeFromNib() {
        super.awakeFromNib()

        tableView.isScrollEnabled = false   // IMPORTANT for nested scrolling
        tableView.separatorStyle = .none

        tableView.delegate = self
        tableView.dataSource = self

        // register the row cell
        tableView.register(
            UINib(nibName: "StrengthTableViewCell", bundle: nil),
            forCellReuseIdentifier: "strength_cell"
        )
    }

    func configure(with items: [StrengthItem]) {
        self.strengths = items
        tableView.reloadData()
        tableView.layoutIfNeeded()  // ensures content height is correct
    }

    /// Used by Compositional Layout to estimate height
    var contentHeight: CGFloat {
        return tableView.contentSize.height
    }
}

extension StrengthsTableContainerCell: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        strengths.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "strength_cell",
            for: indexPath
        ) as! StrengthTableViewCell

        let item = strengths[indexPath.row]
        let isLast = indexPath.row == strengths.count - 1

        cell.configure(with: item, isLast: isLast)

        return cell
    }
}
