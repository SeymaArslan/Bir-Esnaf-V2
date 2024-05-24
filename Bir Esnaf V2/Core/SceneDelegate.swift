//
//  SceneDelegate.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 19.05.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var authListener: AuthStateDidChangeListenerHandle?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        autoLogin()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


    func autoLogin() {
            authListener = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
                guard let self = self else { return }
                // Öncelikle listener'ı kaldırmak istiyoruz çünkü değişiklikleri tekrar dinlemeye gerek yok
                Auth.auth().removeStateDidChangeListener(self.authListener!)

                if user != nil && UserDefaults.standard.object(forKey: "kcurrentUser") != nil {
                    DispatchQueue.main.async {
                        self.goToApp()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.goToLogin()
                    }
                }
            })
        }

        private func goToApp() {
            let homeVC = HomeTabBarController()
            self.window?.rootViewController = homeVC
            self.window?.makeKeyAndVisible()
        }

        private func goToLogin() {
            let loginVC = LoginViewController()
            self.window?.rootViewController = loginVC
            self.window?.makeKeyAndVisible()
        }
    
}

