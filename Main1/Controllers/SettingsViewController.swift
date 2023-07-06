//
//  SettingsViewController.swift
//  Main1
//
//  Created by yahia salman on 4/27/23.
//

import UIKit

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

struct Section {
    let title: String
    let titleColor: UIColor = .systemRed
    let options: [SettingsOption]
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let primaryPurpColor: UIColor = {
        let primaryPurpColor = UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1)
        return primaryPurpColor
    }()

    private let logOutButton = CustomButton(title: "Logout", fontsize: .med, buttonColor: .systemRed, titleColor: .systemRed)
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        table.tintColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        return table
    }()
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontsize: .small, buttonColor: .systemBackground, titleColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1))
    
    var models = [Section]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        self.title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        self.setupUI()
        self.logOutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        
        

        
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        //let logOutButton = UIBarButtonItem( title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))

        
        //logOutButton.tintColor = .red
        
        //self.navigationItem.rightBarButtonItem = logOutButton
        
        self.view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.logOutButton.centerYAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerYAnchor, constant: 45),
            self.logOutButton.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor),
            self.logOutButton.heightAnchor.constraint(equalToConstant: 45),
            self.logOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85)

        ])
        
        
        
    }
    
    @objc private func didTapLogout() {
        AuthService.signOut()
        
        if let sceneDelegate = self.view.window?.windowScene?.delegate as?
            SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
    
    
    
    func configure(){
        models.append(Section(title: "Account", options: [
            SettingsOption(title: "Old Albums", icon: UIImage(systemName: "folder"), iconBackgroundColor: primaryPurpColor){
            },
            SettingsOption(title: "Connections", icon: UIImage(systemName: "link"), iconBackgroundColor: primaryPurpColor){
            }
        ]))
//        models.append(Section(title: "Settings", options: [
//            SettingsOption(title: "Notifications", icon: UIImage(systemName: "bell.badge"), iconBackgroundColor: primaryPurpColor){
//            },
//            SettingsOption(title: "Time Zone", icon: UIImage(systemName: "clock"), iconBackgroundColor: primaryPurpColor){
//            }
//        ]))
        models.append(Section(title: "About", options: [
            SettingsOption(title: "Privacy", icon: UIImage(systemName: "lock"), iconBackgroundColor: primaryPurpColor){
            },
            SettingsOption(title: "Terms & Conditinos", icon: UIImage(systemName: "info"), iconBackgroundColor: primaryPurpColor){
            },
            SettingsOption(title: "Share", icon: UIImage(systemName: "square.and.arrow.up"), iconBackgroundColor: primaryPurpColor){
            }
        ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath
        ) as? SettingsTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(with: model)
        //cell.backgroundColor = .tertiarySystemBackground
        cell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
//        if(indexPath.section == 1 && indexPath.row == 0){
////            let vc = LoginPageViewController()
////            self.navigationController?.pushViewController(vc, animated: true)
//            print("hi")
//        }
        if(indexPath.section == 0 && indexPath.row == 1) {
            let svc = ConnectionsViewController()
            //present(svc, animated: true, completion: nil)
            self.navigationController?.pushViewController(svc, animated: true)
        }
        
    }
    
    

    
}
