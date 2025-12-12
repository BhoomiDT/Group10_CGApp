//
//  SeeResultsViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 10/12/25.
//
import UIKit

class SeeResultsViewController: UIViewController {
    
    var lesson: Lesson?
    var result: TestResult?

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
            super.viewDidLoad()
            // build result from the lesson (factory)
            if let lesson = lesson {
                result = makeTestResult(for: lesson.name)
            } else {
                // fallback (shouldn't happen)
                result = makeTestResult(for: "Unknown Lesson")
            }

            collectionView.dataSource = self
            collectionView.delegate = self

            // register the ScoreCard nib
            collectionView.register(UINib(nibName: "ScoreCardCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "scorecard_cell")

        collectionView.register(
            UINib(nibName: "StrengthsTableContainerCell", bundle: nil),
            forCellWithReuseIdentifier: "strengths_table"
        )
        
            // layout: simple flow where first section is full width
            collectionView.collectionViewLayout = createLayout()
        }

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env in

            // ---------- SECTION 0: SCORE CARD ----------
            if sectionIndex == 0 {
                let size = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(320)
                )
                let item = NSCollectionLayoutItem(layoutSize: size)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
                return section
            }

            // ---------- SECTION 1: STRENGTHS ----------
            if sectionIndex == 1 {
                let size = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(200)    // will expand automatically
                )
                let item = NSCollectionLayoutItem(layoutSize: size)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
                return section
            }

            return nil
        }
    }
}
extension SeeResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 } 

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 1 } // ScoreCard
        if section == 1 { return result?.strengths.count ?? 0 } // Strengths list
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            // SCORE CARD
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "scorecard_cell",
                for: indexPath
            ) as! ScoreCardCollectionViewCell

            cell.configure(with: result!)
            return cell
        }

        if indexPath.section == 1 {
            // STRENGTHS
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "strengths_table",
                for: indexPath
            ) as! StrengthsTableContainerCell

            let item = result!.strengths[indexPath.item]
            let isLast = indexPath.item == result!.strengths.count - 1
            cell.configure(with: result!.strengths)

            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // optional: handle tap on score card
    }
}
