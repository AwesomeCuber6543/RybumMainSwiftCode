//
//  SceneDelegate.swift
//  Main1
//
//  Created by yahia salman on 4/26/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//        window?.windowScene = windowScene
//        //to view original app before login, comment the following lines out
//
//        let vc = LoginPageViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//
//        window?.rootViewController = nav
//        //window?.rootViewController = MainTabBarViewController()
//        window?.makeKeyAndVisible()
        self.setupWindow(with: scene)
        self.checkAuthentication()
    }
   
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    public func checkAuthentication() {
//        let tempVC = MainTabBarViewController()
//        tempVC.modalPresentationStyle = .fullScreen
//        self.window?.rootViewController = tempVC
        DataService.getData { [weak self] result in

            DispatchQueue.main.async {
                switch result {
                case .success(_):
//                    self?.goToController(with: ProfileViewController(dataArray: dataArray))
//                    DispatchQueue.main.async { [weak self] in
//                        UIView.animate(withDuration: 0.25) {
//                            self?.window?.layer.opacity = 0
//                        } completion: { [weak self] _ in
//                            let nav = UINavigationController(rootViewController: MainTabBarViewController())
//                            nav.modalPresentationStyle = .fullScreen
//                            self?.window?.rootViewController = nav
//
//                            UIView.animate(withDuration: 0.25) { [weak self] in
//                                self?.window?.layer.opacity = 1
//
//                            }
//                        }
//
//                    }
                    let tempVC = MainTabBarViewController()
                    tempVC.modalPresentationStyle = .fullScreen
                    self?.window?.rootViewController = tempVC
                case .failure(_):
                    self?.goToController(with: LoginPageViewController())
                }
            }
        }
    }
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                    
                }
            }
            
        }
    }
    
    private func goToHomeController(with homeViewController: UITabBarController, profileDataArray: DataArray) {
        let nav = UINavigationController(rootViewController: homeViewController)
        nav.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = nav
    }
}

