//
//  FriendsTableViewCell.swift
//  Main1
//
//  Created by yahia salman on 7/5/23.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    static let identifier = "FriendsTableViewCell"
    
    private let myImageView: UIImageView = {
        let iv = UIImageView()
        //        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .label
        return iv
    }()
    
    
    
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.text = "Error"
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
//        button.setTitle("Remove", for: .normal)
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapRemoveFriend) , for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureFriendCell(with image: UIImage, and label: String) {
        self.myImageView.image = image
//        self.myImageView.maskCircle(anyImage: image)
        self.myLabel.text = label
        
    }
    
    var removeButtonTappedHandler: (() -> Void)?
        
    @objc private func didTapRemoveFriend() {
        removeButtonTappedHandler?()
    }
    
    private func setupUI() {
        
        self.contentView.addSubview(myImageView)
        self.contentView.addSubview(myLabel)
        self.contentView.addSubview(removeButton)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            myImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            myImageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
//            myImageView.trailingAnchor.constraint(equalTo:self.contentView.layoutMarginsGuide.trailingAnchor, constant: -280),
            myImageView.widthAnchor.constraint(equalToConstant: 50),
//            myImageView.widthAnchor.constraint(equalTo: self.myImageView.heightAnchor),
//            myImageView.heightAnchor.constraint(equalTo: self.myImageView.widthAnchor),
            
            
            myLabel.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 16),
            myLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            myLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            myLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            removeButton.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -10),
            removeButton.heightAnchor.constraint(equalToConstant: 20),
            removeButton.widthAnchor.constraint(equalTo: self.removeButton.heightAnchor),
            removeButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
        ])
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.myImageView.layer.cornerRadius = myImageView.bounds.width / 2
        self.myImageView.clipsToBounds = true
       }
    
}
