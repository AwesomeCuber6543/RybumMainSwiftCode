//
//  UpcomingViewController.swift
//  Main1
//
//  Created by yahia salman on 4/26/23.
//

import UIKit

class FriendsViewController: UIViewController {
    
    private let mainGrayColor: UIColor = {
        let mainGrayColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        return mainGrayColor
    }()
    
    private let addFriendsField = CustomTextField(fieldType: .friends, borderWidth: 0)
    
    
    private let addFriendsButton = CustomButton(title: "Add", hasBackground: true,fontsize: .med, buttonColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1))
    
    private let friendLabel : UILabel = {
        let friendLabel = UILabel()
        friendLabel.text = nil
        return friendLabel
    }()
    
    private var addFriendsButtonLeadingConstraint: NSLayoutConstraint!
    
    private var friendsList: [String] = []
    
    private var friendsProfList: [UIImage] = []
    
    
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        tableView.allowsSelection = false
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad()  {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.updateFriendsList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.updateFriendsProfList()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.setupUI()
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
        self.hideKeyboardWhenTappedAround()
        addFriendsField.delegate = self
        
        self.addFriendsButton.addTarget(self, action: #selector(didTapAddFriend), for: .touchUpInside)
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        

        //view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
    }
    
    
    private func updateFriendsList(){
        self.friendsList = []
        FriendsService.getFriends { [weak self] result in

            DispatchQueue.main.async {
                switch result {
                case .success(let friendsArray):
                    for friend in friendsArray.friends{
                        self!.friendsList.append(friend)
                    }
//                    print(self!.friendsList)
                case .failure(_):
                    break
                }
            }
        }
    }
    
    private func updateFriendsProfList(){
        for username1 in friendsList {
            let userRequest = FriendProfPicRequest(username: username1)
            
            guard let request = Endpoint.getImageFromUsername(userRequest: userRequest).request else {return}
            
            FriendProfService.fetch(request: request) { [weak self] result in
                
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let picArray):
                        let dataDecoded : Data = Data(base64Encoded: picArray.profilepic.last!, options: .ignoreUnknownCharacters)!
                        let decodedimage = UIImage(data: dataDecoded)
                        self.friendsProfList.append(decodedimage!)
//                        print(picArray.profilepic.last!)
                    case .failure(let error):
                        guard let error = error as? ServiceError else { return }
                        
                        switch error {
                        case .serverError(let string),
                                .unkown(let string),
                                .decodingError(let string):
                            AlertManager.showSignInErrorAlert(on: self, with: string)
                        }
                    }
                    
                }
                
                
            }
        }
        
    }
    
    
    
    func setupUI(){
        self.view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        
        
        
        self.view.addSubview(addFriendsField)
        self.view.addSubview(addFriendsButton)
        self.view.addSubview(friendLabel)
        self.view.addSubview(tableView)
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        headerView.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)

        let titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 150, height: headerView.frame.height))
        titleLabel.text = "My Friends"
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white

        headerView.addSubview(titleLabel)

        tableView.tableHeaderView = headerView
        
        addFriendsField.translatesAutoresizingMaskIntoConstraints = false
        addFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        friendLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
                
        addFriendsButtonLeadingConstraint = addFriendsButton.leadingAnchor.constraint(equalTo: view.trailingAnchor)
        
        NSLayoutConstraint.activate([
            self.addFriendsField.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            self.addFriendsField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
//            self.addFriendsField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -75),
            self.addFriendsField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.addFriendsField.heightAnchor.constraint(equalToConstant:45),
            
            self.addFriendsButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
//            self.addFriendsButton.leadingAnchor.constraint(equalTo: self.addFriendsField.trailingAnchor, constant: 10),
//            self.addFriendsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.addFriendsButton.leadingAnchor.constraint(equalTo: self.addFriendsField.trailingAnchor, constant: 10),
            self.addFriendsButton.heightAnchor.constraint(equalToConstant:45),
            self.addFriendsButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            self.friendLabel.topAnchor.constraint(equalTo: self.addFriendsField.bottomAnchor, constant: 10),
            self.friendLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.addFriendsField.bottomAnchor, constant: 45),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -130),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
        ])
        
        self.friendLabel.text = nil
        
    }
    
    private func refreshTableWithFriends() {
        self.updateFriendsList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.updateFriendsProfList()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            print(self.friendsList)
//            print(self.friendsProfList)
            self.tableView.reloadData()
        }
    }
    
    @objc func didPullToRefresh() {
        self.updateFriendsList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.updateFriendsProfList()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            print(self.friendsList)
//            print(self.friendsProfList)
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func didTapAddFriend() {
        addFriendsField.resignFirstResponder()
        let userRequest = FriendRequestRequest(friendsusername: self.addFriendsField.text ?? "")
        
        print(userRequest.friendsusername)
        guard let request = Endpoint.requestFriend(userRequest: userRequest).request else {return}
        
        AuthService.fetch(request: request) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    self.friendLabel.textColor = .green
                    self.friendLabel.text = "sent friend request"
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
//                        AlertManager.showFriendRequestError(on: self, with: string)
                        self.friendLabel.text = ""
                        self.friendLabel.textColor = .systemRed
                        self.friendLabel.text = AlertManager.getFriendRequestError(with: string)
                    }
                }
                
            }
            
            
        }
        
        
    }

}


extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier, for: indexPath) as? FriendsTableViewCell else {
            fatalError("The table view count not deque a custom cell in view controller")
        }
        cell.contentView.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
//        print(indexPath.row)
//        print(self.friendsProfList.count)
        cell.removeButtonTappedHandler = { [weak self] in
            self?.handleRemoveButtonTapped(at: indexPath)
        }
        let name = self.friendsList[indexPath.row]
        let image = self.friendsProfList[indexPath.row]
        cell.configureFriendCell(with: image, and: name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    private func handleRemoveButtonTapped(at indexPath: IndexPath) {
        let username = friendsList[indexPath.row]
        print("Remove button tapped for username:", username)
        
        let userRequest = DeleteFriendRequest(friendsusername: username)
        
        guard let request = Endpoint.deleteFriend(userRequest: userRequest).request else {return}
        
        AuthService.fetch(request: request) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    self.refreshTableWithFriends()
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
                        AlertManager.showRandomAlert(on: self, error: string)
                    }
                }
                
            }
            
            
        }
    }
    
    
}

extension FriendsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
            // Perform animation to slide the button from the right
        print("hello")
        
        let translationDistance: CGFloat = -self.addFriendsButton.frame.width + 65
        let translationDistanceButton: CGFloat = -self.addFriendsButton.frame.width
        
        UIView.animate(withDuration: 0.3) {
            self.addFriendsField.placeholder = ""
            
            self.addFriendsButton.transform = CGAffineTransform(translationX: translationDistanceButton, y: 0)
            
            
            let translation = CGAffineTransform(translationX: translationDistance, y: 0)
            let scaling = CGAffineTransform(scaleX: 0.8, y: 1)
            self.addFriendsField.transform = scaling.concatenating(translation)
            
        }
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("shello")
        
//        self.addFriendsField.placeholder = "Sharboofy"
        // Perform animation to slide the button back to its original position
        UIView.animate(withDuration: 0.3) {
            self.addFriendsButton.transform = .identity
            self.addFriendsField.transform = .identity
            
        }
        self.addFriendsField.placeholder = "Add Friends"
        
    }
}




