//
//  UpcomingViewController.swift
//  Main1
//
//  Created by yahia salman on 4/26/23.
//

import UIKit

class FriendsViewController: UIViewController {
    
    
    private let addFriendsField = CustomTextField(fieldType: .friends, borderWidth: 0)
    
    private let addFriendsButton = CustomButton(title: "Add", hasBackground: true,fontsize: .med, buttonColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1))
    
    private let friendLabel : UILabel = {
        let friendLabel = UILabel()
        friendLabel.text = nil
        return friendLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.addFriendsButton.addTarget(self, action: #selector(didTapAddFriend), for: .touchUpInside)

        //view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        
        self.view.addSubview(addFriendsField)
        self.view.addSubview(addFriendsButton)
        self.view.addSubview(friendLabel)
        
        addFriendsField.translatesAutoresizingMaskIntoConstraints = false
        addFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        friendLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.addFriendsField.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            self.addFriendsField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.addFriendsField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -75),
            self.addFriendsField.heightAnchor.constraint(equalToConstant:45),
            
            self.addFriendsButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            self.addFriendsButton.leadingAnchor.constraint(equalTo: self.addFriendsField.trailingAnchor, constant: 10),
            self.addFriendsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.addFriendsButton.heightAnchor.constraint(equalToConstant:45),
            
            self.friendLabel.topAnchor.constraint(equalTo: self.addFriendsField.bottomAnchor, constant: 10),
            self.friendLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            
        ])
        
        self.friendLabel.text = nil
        
    }
    
    @objc func didTapAddFriend() {
        self.friendLabel.textColor = .green
        self.friendLabel.text = "added friend"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.friendLabel.text = nil
        }
    }

}
