//
//  AdminViewController.swift
//  Main1
//
//  Created by yahia salman on 6/23/23.
//

import UIKit

class AdminViewController: UIViewController {

    private let resetAlbumsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.titleLabel?.text = "RESET ALL ALBUMS"
        button.titleLabel?.textColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.resetAlbumsButton.addTarget(self, action: #selector(didTapResetAlbums), for: .touchUpInside)
        
        
    }
    
    private func setupUI() {
        self.view.addSubview(resetAlbumsButton)
        
        self.resetAlbumsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            resetAlbumsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            resetAlbumsButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            resetAlbumsButton.widthAnchor.constraint(equalToConstant: 150),
            resetAlbumsButton.heightAnchor.constraint(equalToConstant: 40),
        
        ])
        
    }
    


    
    @objc func didTapResetAlbums(){
        print("shit")
    }
}
