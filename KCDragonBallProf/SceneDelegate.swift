//
//  SceneDelegate.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 20/11/24.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appState: AppState = AppState()
    var cancellable: AnyCancellable?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = SplashBuilder().build()
        self.window?.makeKeyAndVisible()
        
        
        appState.statusLogin = .loading
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.appState.validateControlLogin()
        }
        
        var navigationController: UINavigationController?
        
        self.cancellable = appState.$statusLogin
            .sink(receiveValue: { state in
                switch state {
               
                case .loading:
                    break
                case .none:
                    DispatchQueue.main.async {
                        
                        navigationController = UINavigationController(rootViewController: LoginViewController(appState: self.appState))
                        self.window!.rootViewController = navigationController
                        self.window!.makeKeyAndVisible()
                    }
                case .success:
                    DispatchQueue.main.async {
                        print("Heroes List")
                        navigationController = UINavigationController(rootViewController: HeroesListViewController(appState: self.appState, viewModel: HeroesViewModel() ))
                        self.window!.rootViewController = navigationController
                        self.window!.makeKeyAndVisible()
                    }
                case .error:
                    
                    DispatchQueue.main.async {
                        print("Error al home")
                        navigationController = UINavigationController(rootViewController: ErrorViewController(appState: self.appState, error: "Error en el login usuario/clave"))
                        self.window!.rootViewController = navigationController
                        self.window!.makeKeyAndVisible()
                    }
                    
                case .notValidate:
                    DispatchQueue.main.async {
                        print("Login")
                        navigationController = UINavigationController(rootViewController: LoginViewController(appState: self.appState))
                        self.window!.rootViewController = navigationController
                        self.window!.makeKeyAndVisible()
                    }
                
                }
            })
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


}

