//
//  YourAnswersViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//

// YourAnswersViewController.swift

import UIKit

var questions: [QuestionAnswer] = userAnswersData

class YourAnswersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellReuseIdentifier = "AnswerStatusCell"
    
    @IBOutlet weak var answersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        answersTableView.dataSource = self
        answersTableView.delegate = self
        
//        let nib = UINib(nibName: cellReuseIdentifier, bundle: nil)
//        answersTableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        
        navigationItem.title = "Your Answers"
        answersTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? AnswerStatusCell else {
            fatalError("Could not dequeue AnswerStatusCell.")
        }
        
        let question = questions[indexPath.row]
        
        cell.configure(with: question)
        
//        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Row tapped: \(questions[indexPath.row].questionText)")
    }
}
