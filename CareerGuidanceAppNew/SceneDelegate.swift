import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 1. Create the window
        let window = UIWindow(windowScene: windowScene)
        
        // ⚠️ Reset for testing (Remove later)
        OnboardingManager.shared.resetOnboarding()
        
        // 2. Determine Logic
        let rootViewController: UIViewController
        
        if OnboardingManager.shared.isTechSkillsCompleted {
            print("User Status: Returning User (Going to Home)")
            let homeStoryboard = UIStoryboard(name: "HomePageProfileNew", bundle: nil)
            guard let homeVC = homeStoryboard.instantiateInitialViewController() else { return }
            rootViewController = homeVC
        } else {
            print("User Status: New User (Going to Onboarding)")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let startVC = mainStoryboard.instantiateViewController(withIdentifier: "IntroVC") as? onboardingSectionIntroViewController {
                startVC.sectionIndex = 0
                rootViewController = startVC
            } else {
                rootViewController = UIViewController()
            }
        }
        
        // 3. Setup Navigation Controller & Large Titles
        if let navVC = rootViewController as? UINavigationController {
            navVC.navigationBar.prefersLargeTitles = true
            window.rootViewController = navVC
        } else {
            let navigationController = UINavigationController(rootViewController: rootViewController)
            navigationController.navigationBar.prefersLargeTitles = true
            window.rootViewController = navigationController
        }
        
        // MARK: - 👇 THIS WAS MISSING
        // 4. Attach the window to the scene and make it visible
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
