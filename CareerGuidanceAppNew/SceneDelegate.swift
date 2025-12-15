//
//  SceneDelegate.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // ---------------------------------------------------------
        // DEFAULT BEHAVIOR:
        // This will load the Main.storyboard automatically.
        // KEEPING THIS because you want HEAD behavior.
        // ---------------------------------------------------------
        guard let _ = (scene as? UIWindowScene) else { return }


        // ---------------------------------------------------------
        // CUSTOM STORYBOARD LAUNCH (COMMENTED OUT)
        // Uncomment this block ONLY if you want to launch
        // another storyboard (e.g., "Badges", "MyJourney", etc.)
        // ---------------------------------------------------------

        /*
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)


        // Instantiate the initial view controller from Extra.storyboard
        let storyboard = UIStoryboard(name: "Answers", bundle: nil) // "Extra" is the filename (case-sensitive)
        guard let initialVC = storyboard.instantiateInitialViewController() else {
            print("⚠️ ERROR: Could not instantiate initial VC from storyboard. Check 'Is Initial View Controller'.")
            return
        }

        window.rootViewController = initialVC
        self.window = window
        window.makeKeyAndVisible()
        */

    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
