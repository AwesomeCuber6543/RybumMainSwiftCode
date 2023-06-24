//
//  UpcomingViewController.swift
//  Main1
//
//  Created by yahia salman on 4/26/23.
//

import UIKit

class FriendsViewController: UIViewController {
    
    
    private let addFriendsField = CustomTextField(fieldType: .friends, borderWidth: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

        //view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        
        self.view.addSubview(addFriendsField)
        
        addFriendsField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.addFriendsField.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            self.addFriendsField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.addFriendsField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -75),
            self.addFriendsField.heightAnchor.constraint(equalToConstant:45),
            
            
        ])
        
    }
    

}
