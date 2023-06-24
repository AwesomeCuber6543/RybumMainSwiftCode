//
//  ViewController.swift
//  Main1
//
//  Created by yahia salman on 4/26/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        EmailService.getEmail { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let emailArray):
                    if (emailArray.returnedEmail.last == "info.rybum@gmail.com") {
                        let vc1 = UINavigationController(rootViewController: HomeViewController())
                        let vc2 = UINavigationController(rootViewController: AdminViewController())
                        //let vc3 = UINavigationController(rootViewController: ProfileViewController(dataArray: dataArray))
                        let vc4 = UINavigationController(rootViewController: TrialProfileViewController())
                        //let vc3 = UINavigationController(rootViewController: CameraViewController())
                        //let vc5 = UINavigationController(rootViewController: SettingsViewController())
                        //let vc6 = UINavigationController(rootViewController: SettingsButtonViewController())
                        
                        
                        vc1.tabBarItem.image = UIImage(systemName: "music.note")
                        vc2.tabBarItem.image = UIImage(systemName: "person.3")
                        //vc3.tabBarItem.image = UIImage(systemName: "camera")
                        vc4.tabBarItem.image = UIImage(systemName: "person.circle")
                        //vc5.tabBarItem.image = UIImage(systemName: "gear.circle")
                        //vc6.tabBarItem.image = UIImage(systemName: "gear.circle")
                        vc1.toolbar.tintColor = .white
                        
                        vc1.title = "Albums"
                        vc2.title = "AdminView"
                        //vc3.title = "Camera"
                        vc4.title = "Profile"
                        //vc5.title = "Settings"
                        //vc6.title = "STS"
                        
                        //self?.tabBar.tintColor = .label
                        
            //                    self?.setViewControllers([vc2, vc1, vc4], animated: true)
                        self!.setViewControllers([vc1, vc4, vc2], animated: true)
                    }
                    else {
                        let vc1 = UINavigationController(rootViewController: HomeViewController())
                        let vc2 = UINavigationController(rootViewController: FriendsViewController())
                        //let vc3 = UINavigationController(rootViewController: ProfileViewController(dataArray: dataArray))
                        let vc4 = UINavigationController(rootViewController: TrialProfileViewController())
                        //let vc3 = UINavigationController(rootViewController: CameraViewController())
                        //let vc5 = UINavigationController(rootViewController: SettingsViewController())
                        //let vc6 = UINavigationController(rootViewController: SettingsButtonViewController())
                        
                        
                        vc1.tabBarItem.image = UIImage(systemName: "music.note")
                        vc2.tabBarItem.image = UIImage(systemName: "person.3")
                        //vc3.tabBarItem.image = UIImage(systemName: "camera")
                        vc4.tabBarItem.image = UIImage(systemName: "person.circle")
                        //vc5.tabBarItem.image = UIImage(systemName: "gear.circle")
                        //vc6.tabBarItem.image = UIImage(systemName: "gear.circle")
                        vc1.toolbar.tintColor = .white
                        
                        vc1.title = "Albums"
                        vc2.title = "Friends"
                        //vc3.title = "Camera"
                        vc4.title = "Profile"
                        //vc5.title = "Settings"
                        //vc6.title = "STS"
                        
                        //self?.tabBar.tintColor = .label
                        
            //                    self?.setViewControllers([vc2, vc1, vc4], animated: true)
                        self!.setViewControllers([vc1, vc4], animated: true)
                    }
                case .failure(_):
                    let vc1 = UINavigationController(rootViewController: HomeViewController())
                    let vc2 = UINavigationController(rootViewController: FriendsViewController())
                    //let vc3 = UINavigationController(rootViewController: ProfileViewController(dataArray: dataArray))
                    let vc4 = UINavigationController(rootViewController: TrialProfileViewController())
                    //let vc3 = UINavigationController(rootViewController: CameraViewController())
                    //let vc5 = UINavigationController(rootViewController: SettingsViewController())
                    //let vc6 = UINavigationController(rootViewController: SettingsButtonViewController())
                    
                    
                    vc1.tabBarItem.image = UIImage(systemName: "music.note")
                    vc2.tabBarItem.image = UIImage(systemName: "person.3")
                    //vc3.tabBarItem.image = UIImage(systemName: "camera")
                    vc4.tabBarItem.image = UIImage(systemName: "person.circle")
                    //vc5.tabBarItem.image = UIImage(systemName: "gear.circle")
                    //vc6.tabBarItem.image = UIImage(systemName: "gear.circle")
                    vc1.toolbar.tintColor = .white
                    
                    vc1.title = "Albums"
                    vc2.title = "Friends"
                    //vc3.title = "Camera"
                    vc4.title = "Profile"
                    //vc5.title = "Settings"
                    //vc6.title = "STS"
                    
                    //self?.tabBar.tintColor = .label
                    
        //                    self?.setViewControllers([vc2, vc1, vc4], animated: true)
                    self!.setViewControllers([vc1, vc4], animated: true)
                }
            }
            
        }
        print("here 2")
//        if isAdmin.admin == true{
//            let vc1 = UINavigationController(rootViewController: HomeViewController())
//            let vc2 = UINavigationController(rootViewController: AdminViewController())
//            //let vc3 = UINavigationController(rootViewController: ProfileViewController(dataArray: dataArray))
//            let vc4 = UINavigationController(rootViewController: TrialProfileViewController())
//            //let vc3 = UINavigationController(rootViewController: CameraViewController())
//            //let vc5 = UINavigationController(rootViewController: SettingsViewController())
//            //let vc6 = UINavigationController(rootViewController: SettingsButtonViewController())
//
//
//            vc1.tabBarItem.image = UIImage(systemName: "music.note")
//            vc2.tabBarItem.image = UIImage(systemName: "person.3")
//            //vc3.tabBarItem.image = UIImage(systemName: "camera")
//            vc4.tabBarItem.image = UIImage(systemName: "person.circle")
//            //vc5.tabBarItem.image = UIImage(systemName: "gear.circle")
//            //vc6.tabBarItem.image = UIImage(systemName: "gear.circle")
//            vc1.toolbar.tintColor = .white
//
//            vc1.title = "Albums"
//            vc2.title = "AdminView"
//            //vc3.title = "Camera"
//            vc4.title = "Profile"
//            //vc5.title = "Settings"
//            //vc6.title = "STS"
//
//            //self?.tabBar.tintColor = .label
//
////                    self?.setViewControllers([vc2, vc1, vc4], animated: true)
//            self.setViewControllers([vc1, vc4, vc2], animated: true)
//            //self?.tabBar.window?.rootViewController = vc1
//        }
//        else {
//            let vc1 = UINavigationController(rootViewController: HomeViewController())
//            let vc2 = UINavigationController(rootViewController: FriendsViewController())
//            //let vc3 = UINavigationController(rootViewController: ProfileViewController(dataArray: dataArray))
//            let vc4 = UINavigationController(rootViewController: TrialProfileViewController())
//            //let vc3 = UINavigationController(rootViewController: CameraViewController())
//            //let vc5 = UINavigationController(rootViewController: SettingsViewController())
//            //let vc6 = UINavigationController(rootViewController: SettingsButtonViewController())
//            
//            
//            vc1.tabBarItem.image = UIImage(systemName: "music.note")
//            vc2.tabBarItem.image = UIImage(systemName: "person.3")
//            //vc3.tabBarItem.image = UIImage(systemName: "camera")
//            vc4.tabBarItem.image = UIImage(systemName: "person.circle")
//            //vc5.tabBarItem.image = UIImage(systemName: "gear.circle")
//            //vc6.tabBarItem.image = UIImage(systemName: "gear.circle")
//            vc1.toolbar.tintColor = .white
//            
//            vc1.title = "Albums"
//            vc2.title = "Friends"
//            //vc3.title = "Camera"
//            vc4.title = "Profile"
//            //vc5.title = "Settings"
//            //vc6.title = "STS"
//            
//            //self?.tabBar.tintColor = .label
//            
////                    self?.setViewControllers([vc2, vc1, vc4], animated: true)
//            self.setViewControllers([vc1, vc4], animated: true)
//            //self?.tabBar.window?.rootViewController = vc1
//            
//        }
    }
}

