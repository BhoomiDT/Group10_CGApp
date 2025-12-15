import Foundation
import UIKit

class OnboardingManager {
    static let shared = OnboardingManager()
    
    private let defaults = UserDefaults.standard
    private let kTechSkillsCompleted = "kTechSkillsCompleted"
    private let kCompletedSections = "kCompletedSections"
    private let kUserTechSkills = "kUserTechSkills"
    
    // Reference to your existing data model
    let questionnaire = Questionnaire()
    
    private init() {}
    
    // MARK: - State Properties
    
    var isTechSkillsCompleted: Bool {
        get { return defaults.bool(forKey: kTechSkillsCompleted) }
        set { defaults.set(newValue, forKey: kTechSkillsCompleted) }
    }
    
    var completedSectionIndexes: [Int] {
        get { return defaults.array(forKey: kCompletedSections) as? [Int] ?? [] }
        set { defaults.set(newValue, forKey: kCompletedSections) }
    }
    
    // MARK: - Actions
    
    func saveTechSkills(_ skills: [String]) {
        defaults.set(skills, forKey: kUserTechSkills)
        isTechSkillsCompleted = true
        markSectionCompleted(index: 1)
    }
    
    func markSectionCompleted(index: Int) {
        var completed = completedSectionIndexes
        if !completed.contains(index) {
            completed.append(index)
            completedSectionIndexes = completed
            print("✅ Section \(index) marked as completed.")
        }
    }
    
    // MARK: - Logic & Routing
    
    func getProgress() -> Float {
        let totalSteps = Float(questionnaire.sections.count)
        guard totalSteps > 0 else { return 0.0 }
        let stepsCompleted = Float(completedSectionIndexes.count)
        return stepsCompleted / totalSteps
    }
    
    func isOnboardingFullyComplete() -> Bool {
        return getProgress() >= 1.0
    }
    
    // FIX: Removed the 'from storyboard' parameter.
    // We explicitly load the "Main" storyboard inside this function now.
    func getNextViewController() -> UIViewController? {
        
        // 1. Force load from Main.storyboard, where IntroVC and TechnicalSkills live
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. Iterate to find the first INCOMPLETE section
        for (index, _) in questionnaire.sections.enumerated() {
            
            if !completedSectionIndexes.contains(index) {
                
                // Case: Tech Skills (Index 1) needs special handling if you want to skip Intro
                // But generally, we route to IntroVC first
                if let introVC = mainStoryboard.instantiateViewController(withIdentifier: "IntroVC") as? onboardingSectionIntroViewController {
                    introVC.sectionIndex = index
                    return introVC
                }
            }
        }
        
        return nil // Onboarding is done
    }
    
    // MARK: - Debugging
    func resetOnboarding() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        print("⚠️ Onboarding Reset")
    }
}
