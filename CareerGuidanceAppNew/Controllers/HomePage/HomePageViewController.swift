import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Data Models
    let roadmapData = RoadmapModel.sampleData
    let trendingData = TrendingModel.sampleData
    let journeyData = JourneyModel.sampleData
    
    // MARK: - Navigation Flags
    var shouldShowRoadmap: Bool = true
    var shouldUpdateProgress: Bool = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
        collectionView.backgroundColor = .appBackground
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

    
        collectionView.register(UINib(nibName: "StatsCard", bundle: nil), forCellWithReuseIdentifier: "StatsCard")
        collectionView.register(UINib(nibName: "roadmapScrollCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "roadmapScrollCollectionViewCell")
        collectionView.register(UINib(nibName: "homepageMyJourney", bundle: nil), forCellWithReuseIdentifier: "homepageMyJourney")
        collectionView.register(UINib(nibName: "showLeaderboard", bundle: nil), forCellWithReuseIdentifier: "showLeaderboard")
        collectionView.register(UINib(nibName: "viewBadges", bundle: nil), forCellWithReuseIdentifier: "viewBadges")
        collectionView.register(UINib(nibName: "trendingHomePage", bundle: nil), forCellWithReuseIdentifier: "trendingHomePage")
        collectionView.register(UINib(nibName: "onboardingNotCompleted", bundle: nil), forCellWithReuseIdentifier: "onboardingNotCompleted")
        
        collectionView.register(HomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier)

        collectionView.collectionViewLayout = createLayout()
    }

    // MARK: - CollectionView DataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int { 6 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            // LOGIC FIX:
            // If Onboarding is COMPLETE -> Show Roadmap (count of items)
            // If Onboarding is NOT COMPLETE -> Show 1 item (The Progress Card)
            if OnboardingManager.shared.isOnboardingFullyComplete() {
                return roadmapData.count
            } else {
                return 1
            }
        }
        
        if section == 5 { return trendingData.count }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatsCard", for: indexPath) as! StatsCard
            cell.configure(with: UserStats.demo)
            return cell
            
        case 1:
            // LOGIC FIX: Check Completion
            if OnboardingManager.shared.isOnboardingFullyComplete() {
                // 1. ONBOARDING DONE -> SHOW ROADMAP CARDS
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roadmapScrollCollectionViewCell", for: indexPath) as! roadmapScrollCollectionViewCell
                let data = roadmapData[indexPath.row]
                cell.configure(title: data.title, subtitle: data.subtitle, percentage: data.percentage, milestone: data.milestone)
                return cell
            } else {
                // 2. ONBOARDING NOT DONE -> SHOW PROGRESS CARD
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingNotCompleted", for: indexPath) as! onboardingNotCompleted
                let progress = OnboardingManager.shared.getProgress()
                cell.progressBarOnboarding.progress = progress
                cell.continuePersonalisationButton.addTarget(self, action: #selector(didTapContinueOnboarding), for: .touchUpInside)
                return cell
            }
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homepageMyJourney", for: indexPath) as! homepageMyJourney
            cell.configure(days: journeyData.days, quizzes: journeyData.quizzes, quests: journeyData.quests)
            return cell
            
        case 3:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "showLeaderboard", for: indexPath)
        case 4:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "viewBadges", for: indexPath)
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trendingHomePage", for: indexPath) as! trendingHomePage
            cell.configure(item: trendingData[indexPath.row])
            return cell
        }
    }
    
    @objc func didTapContinueOnboarding() {
            // Updated call: No parameter needed
            if let nextVC = OnboardingManager.shared.getNextViewController() {
                navigationController?.pushViewController(nextVC, animated: true)
            }
        }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier, for: indexPath) as! HomeSectionHeaderView
        header.viewAllButton.isHidden = true
        header.onViewAllTapped = nil
        
        switch indexPath.section {
        case 1:
            if OnboardingManager.shared.isOnboardingFullyComplete() {
                header.titleLabel.text = "My Roadmaps"
            } else {
                header.titleLabel.text = "Finish Setup"
            }
        case 2: header.titleLabel.text = "My Journey"
        case 5: header.titleLabel.text = "Trending Domains"; header.viewAllButton.isHidden = false
        default: header.titleLabel.text = ""
        }
        
        return header
    }

    // MARK: - Layout Creation
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            if sectionIndex == 1 {
                // LOGIC FIX: Switch Layout based on Completion
                if OnboardingManager.shared.isOnboardingFullyComplete() {
                    // LAYOUT A: Horizontal Scrolling Roadmap
                    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                    item.contentInsets.trailing = 15
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(165)), subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .groupPaging
                    section.contentInsets = .init(top: 0, leading: 16, bottom: 20, trailing: 16)
                    section.boundarySupplementaryItems = [header]
                    return section
                } else {
                    // LAYOUT B: Single Static Card
                    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(170)), subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = .init(top: 0, leading: 16, bottom: 20, trailing: 16)
                    section.boundarySupplementaryItems = [header]
                    return section
                }
            }
            
            // ... (Rest of layout logic remains exactly the same) ...
            else if sectionIndex == 5 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))); item.contentInsets.trailing = 12
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(220)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group); section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 10, leading: 16, bottom: 30, trailing: 16); section.boundarySupplementaryItems = [header]
                section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                    items.forEach { item in
                        let dist = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                        let scale = max(1.0 - (dist / environment.container.contentSize.width), 0.95)
                        item.transform = CGAffineTransform(scaleX: scale, y: scale)
                    }
                }
                return section
            } else {
                let height: CGFloat = (sectionIndex == 0 ? 130 : (sectionIndex == 2 ? 275 : 60))
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: (sectionIndex == 3 || sectionIndex == 4) ? 12 : 0, leading: 16, bottom: 10, trailing: 16)
                if sectionIndex == 2 { section.boundarySupplementaryItems = [header] }
                return section
            }
        }
    }
}
// MARK: - Header Class (Unchanged)
class HomeSectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let viewAllButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("View All", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        btn.tintColor = .appTeal
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        return btn
    }()
    
    var onViewAllTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(viewAllButton)
        
        viewAllButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            viewAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            viewAllButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    @objc private func handleTap() {
        onViewAllTapped?()
    }
}
