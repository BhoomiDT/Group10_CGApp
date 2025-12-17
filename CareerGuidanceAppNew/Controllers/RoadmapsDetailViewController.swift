//
//  RoadmapsDetailViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 28/11/25.
//

// RoadmapDetailViewController.swift

import UIKit

class RoadmapDetailViewController: UIViewController, RoadmapLessonRowCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var selectedRoadmap: Roadmap!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.title = selectedRoadmap.title
            setupTableView()
        }

        private func setupTableView() {

            // Register Header Cell (card top)
            let headerNib = UINib(nibName: "RoadmapSectionHeaderCell", bundle: nil)
            tableView.register(headerNib, forCellReuseIdentifier: "section_header_cell")

            // Register Lesson Cell (rows inside card)
            let lessonNib = UINib(nibName: "RoadmapLessonRowCell", bundle: nil)
            tableView.register(lessonNib, forCellReuseIdentifier: "lesson_row_cell")

            tableView.dataSource = self
            tableView.delegate = self

            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 80

            tableView.separatorStyle = .none
            tableView.backgroundColor = .systemGroupedBackground
            view.backgroundColor = .systemGroupedBackground
        }
    
    func roadmapLessonRowCell(_ cell: RoadmapLessonRowCell, didTapStatusFor lesson: Lesson) {
            switch lesson.status {
            case .seeResults:
                // open Results screen
                openResults(for: lesson)
            case .startTest:
                // open Test/Quiz screen
                openTest(for: lesson)
            }
        }

    private func openResults(for lesson: Lesson) {
        let storyboard = UIStoryboard(name: "Roadmaps", bundle: nil)
        guard let resultsVC = storyboard.instantiateViewController(withIdentifier: "TestResultsVC") as? TestResultsViewController else {
            print("TestResultsViewController not found")
            return
        }
        resultsVC.lesson = lesson
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    private func openTest(for lesson: Lesson) {
        let storyboard = UIStoryboard(name: "Roadmaps", bundle: nil)
        guard let modalVC = storyboard.instantiateViewController(
            withIdentifier: "StartTestModalVC"
        ) as? StartTestModalViewController else { return }

        modalVC.lesson = lesson
        modalVC.delegate = self

        if let sheet = modalVC.sheetPresentationController {
            let customDetent = UISheetPresentationController.Detent.custom { context in
                return 550
            }

            sheet.detents = [customDetent]
            sheet.prefersGrabberVisible = false
            sheet.preferredCornerRadius = 20
            //sheet.largestUndimmedDetentIdentifier = nil
        }
        print("Delegate set:", modalVC.delegate != nil)
        present(modalVC, animated: true)
    }
    }

// MARK: - Section Headers for Module Titles
extension RoadmapDetailViewController {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let title = "Module \(section + 1)"

        let header = UIView()
        header.backgroundColor = .clear

        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label

        header.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -8)
        ])

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44   // adjust to match the left screenshot (42–56 looks good)
    }
}

    // MARK: - TABLE DATA SOURCE
    extension RoadmapDetailViewController: UITableViewDataSource {

        func numberOfSections(in tableView: UITableView) -> Int {
            return selectedRoadmap.modules.count
        }

        // 1 header row + lesson count
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1 + selectedRoadmap.modules[section].lessons.count
        }

        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let module = selectedRoadmap.modules[indexPath.section]

            if indexPath.row == 0 {
                // -------- HEADER CELL --------
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "section_header_cell",
                    for: indexPath
                ) as! RoadmapSectionHeaderCell

                // Module due date = due date of first lesson
                if let firstDue = module.lessons.first?.dueDate {
                    cell.configure(dueText: "Due \(firstDue)")
                }

                // Round top corners only
                cell.cardContainerView.layer.cornerRadius = 12
                cell.cardContainerView.layer.maskedCorners = [.layerMinXMinYCorner,
                                                              .layerMaxXMinYCorner]

                return cell
            } else {

                // -------- LESSON CELL --------
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "lesson_row_cell",
                    for: indexPath
                ) as! RoadmapLessonRowCell

                let lessonIndex = indexPath.row - 1
                let lesson = module.lessons[lessonIndex]
                let lastIndex = module.lessons.count - 1

                cell.configure(with: lesson)
                cell.delegate = self
                // CELL CORNER LOGIC
                let isFirstLesson = lessonIndex == 0
                let isLastLesson = lessonIndex == lastIndex

                cell.setCorners(
                    topLeft: isFirstLesson,
                    topRight: isFirstLesson,
                    bottomLeft: isLastLesson,
                    bottomRight: isLastLesson,
                    hideSeparator: isLastLesson
                )

                return cell
            }
        }
    }

    extension RoadmapDetailViewController: UITableViewDelegate {

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            if indexPath.row == 0 { return } // header tap ignored

            let lessonIndex = indexPath.row - 1
            let lesson = selectedRoadmap.modules[indexPath.section].lessons[lessonIndex]

            print("Tapped on: \(lesson.name) → \(lesson.status.rawValue)")

            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
extension RoadmapDetailViewController: StartTestModalDelegate {

    func didTapStartTest(quiz: Quiz) {
        let sb = UIStoryboard(name: "Roadmaps", bundle: nil)

        guard let quizVC = sb.instantiateViewController(
            withIdentifier: "QuestionVC"
        ) as? QuizViewController else {
            print("QuestionVC not found")
            return
        }

        quizVC.quiz = quiz
        print("Entered QuizVC \(quiz.lessonName)")
        print(quiz.questions.count)
        
        navigationController?.pushViewController(quizVC, animated: true)
    }
}
