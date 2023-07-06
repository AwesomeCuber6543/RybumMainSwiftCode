//
//  TrialProfileViewController.swift
//  Main1
//
//  Created by yahia salman on 6/19/23.
//

import UIKit

class TrialProfileViewController: UIViewController {

//    private let addPhotoButton = CustomButton(title: "Select Photo", fontsize: .med, buttonColor: .systemRed)
    
    
    
    private let addPhotoButton: UIButton = {
        let addPhotoButton = UIButton()
        addPhotoButton.backgroundColor = .white
        addPhotoButton.frame = CGRect(x: 350, y: 85, width: 44, height: 44)
        addPhotoButton.backgroundColor = .white
        return addPhotoButton
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading Username"
        label.numberOfLines = 1
        return label
    }()
    
    private let settingsButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.layer.cornerRadius = 7
        settingsButton.frame = CGRect(x: 350, y: 85, width: 44, height: 44)
//        settingsButton.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        
        settingsButton.backgroundColor = nil
        return settingsButton
    }()
    
    private let friendsButton: UIButton = {
        let friendsButton = UIButton()
        friendsButton.layer.cornerRadius = 7
        friendsButton.frame = CGRect(x: 350, y: 85, width: 44, height: 44)
//        settingsButton.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        
        friendsButton.backgroundColor = nil
        return friendsButton
    }()
    
    private let contentView = UIImageView()
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    
    
    private let imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: -100, y: -50, width: 2600, height: 2600))
        //imageView.layer.cornerRadius = imageView.frame.size.height/2
//        imageView.image = UIImage(named: "rybumskinnylogo")
        imageView.image = nil
        return imageView
    }()
    
    private let backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView(frame: CGRect(x: -100, y: -50, width: 2600, height: 2600))
//        backgroundImageView.image = UIImage(named: "rybumskinnylogo")
        backgroundImageView.image = nil
        return backgroundImageView
    }()

    
    private let newProfPic : String = ""
    
    private func setBaseImage() {
        ImageService.getImage { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let profilePicsArray):
                    if (profilePicsArray.profilepic.isEmpty == false){
                        let dataDecoded : Data = Data(base64Encoded: profilePicsArray.profilepic.last!, options: .ignoreUnknownCharacters)!
                        let decodedimage = UIImage(data: dataDecoded)
                        self!.imageView.maskCircle(anyImage: decodedimage!)
    //                    self!.imageView.image = decodedimage
                        break
                    }
                    else {
                        self!.imageView.maskCircle(anyImage: UIImage(named: "rybumskinnylogo")!)
                    }
                    
                   
                    //print(profilePicsArray)
                case .failure(_):
                    print("nah")
                    break
                }
            }
            
        }
    }
    
    private func setBackgroundBaseImage() {
        ImageService.getImage { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let profilePicsArray):
                    if (profilePicsArray.profilepic.isEmpty == false){
                        let dataDecoded : Data = Data(base64Encoded: profilePicsArray.profilepic.last!, options: .ignoreUnknownCharacters)!
                        let decodedimage = UIImage(data: dataDecoded)
//                        self!.imageView.maskCircle(anyImage: decodedimage!)
                        self!.backgroundImageView.image = decodedimage
                        break
                    }
                    else {
                        self!.backgroundImageView.image = UIImage(named: "rybumskinnylogo")
                    }
                    
                   
                    //print(profilePicsArray)
                case .failure(_):
                    print("nah")
                    break
                }
            }
            
        }
    }
    
    private func setUsername() {
        UsernameService.getUsername{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let usernameArray):
                    self!.label.text = usernameArray.username.last!
                case .failure(_):
                    self?.label.text = "placeholder"
                }
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
        
        self.setupUI()
        self.addPhotoButton.addTarget(self, action: #selector(didTapAddPhoto), for: .touchUpInside)
        self.settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        self.friendsButton.addTarget(self, action: #selector(didTapFriendsButton), for: .touchUpInside)
//        self.addPhotoButton.setImage(UIImage(named: "pencil"), for: .normal)
//        self.addPhotoButton.layer.cornerRadius = self.addPhotoButton.frame.height / 2
//        self.addPhotoButton.backgroundColor = .black

        
    }
    
    private func setupUI() {
        
        self.view.addSubview(label)
        self.view.addSubview(friendsButton)
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(addPhotoButton)
        self.view.addSubview(imageView)
        self.view.addSubview(blurView)
        self.view.addSubview(settingsButton)

        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.friendsButton.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.blurView.translatesAutoresizingMaskIntoConstraints = false
        self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.bringSubviewToFront(friendsButton)
        self.view.bringSubviewToFront(settingsButton)
        self.view.sendSubviewToBack(imageView)
        self.view.sendSubviewToBack(blurView)
        self.view.sendSubviewToBack(backgroundImageView)
        
        //contentView.backgroundColor = .systemRed
//        contentView.image = UIImage(named: "rybumlogoskinny")
//        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 250)
        
        
//        ImageService.getImage { [weak self] result in
//
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let profilePicsArray):
//                    if (profilePicsArray.profilepic.isEmpty == false){
//                        let dataDecoded : Data = Data(base64Encoded: profilePicsArray.profilepic.last!, options: .ignoreUnknownCharacters)!
////                        let decodedimage = UIImage(data: dataDecoded)
//                        backgroundImageView.image = UIImage(data: dataDecoded)
//
//    //                    self!.imageView.image = decodedimage
//                        break
//                    }
//                    else {
//                        self!.imageView.maskCircle(anyImage: UIImage(named: "rybumskinnylogo")!)
//                    }
//
//
//                    //print(profilePicsArray)
//                case .failure(_):
//                    print("nah")
//                    break
//                }
//            }
//
//        }
//        self.contentView.sendSubviewToBack(backgroundImageView)

        setBaseImage()
        setBackgroundBaseImage()
        setUsername()
        
//        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
//
//        let largeBoldDoc = UIImage(systemName: "pencil.circle", withConfiguration: largeConfig)
//
//        addPhotoButton.setImage(largeBoldDoc, for: .normal)

        NSLayoutConstraint.activate([
            
            
            
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.backgroundImageView.heightAnchor.constraint(equalToConstant:250),
            //self.backgroundImageView.widthAnchor.constraint(equalToConstant: 130),
            
//            self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 125),
//            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
//            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -130),
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant:130),
            self.imageView.widthAnchor.constraint(equalToConstant: 130),
            self.imageView.centerYAnchor.constraint(equalTo: self.backgroundImageView.centerYAnchor, constant: 5),
            
            self.blurView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.blurView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.blurView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.blurView.heightAnchor.constraint(equalToConstant:250),
            //self.blurView.widthAnchor.constraint(equalToConstant: 130),

//            self.addPhotoButton.topAnchor.constraint(equalTo: imageView.layoutMarginsGuide.bottomAnchor, constant: 80),
//            self.addPhotoButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: 175),
//            self.addPhotoButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -175),
            self.addPhotoButton.widthAnchor.constraint(equalToConstant: 40),
            self.addPhotoButton.heightAnchor.constraint(equalTo: self.addPhotoButton.widthAnchor),
            self.addPhotoButton.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor, constant: 45),
            self.addPhotoButton.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: 45),
            
            self.settingsButton.widthAnchor.constraint(equalToConstant: 42),
            self.settingsButton.heightAnchor.constraint(equalTo: self.settingsButton.widthAnchor),
//            self.settingsButton.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor, constant: 45),
            self.settingsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.settingsButton.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: -40),
            
//            self.settingsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            self.settingsButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            
            self.friendsButton.widthAnchor.constraint(equalToConstant: 45),
            self.friendsButton.heightAnchor.constraint(equalToConstant: 25),
//            self.settingsButton.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor, constant: 45),
            self.friendsButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.friendsButton.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: -40),
            
            self.label.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10),
//            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
            
        
        
        ])
        self.addPhotoButton.layer.cornerRadius = self.addPhotoButton.frame.width/2
        
        let largeConfigPic = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .medium)
               
        let largeBoldDocPic = UIImage(systemName: "pencil", withConfiguration: largeConfigPic)
        
        self.addPhotoButton.setImage(largeBoldDocPic, for: .normal)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
               
        let largeBoldDoc = UIImage(systemName: "gear.circle", withConfiguration: largeConfig)
        
        settingsButton.setImage(largeBoldDoc, for: .normal)
        
        let largeBoldDocFriends = UIImage(systemName: "person.3", withConfiguration: largeConfigPic)
        
        friendsButton.setImage(largeBoldDocFriends, for: .normal)
        
        settingsButton.tintColor = .white
        friendsButton.tintColor = .white

        
        
    }
    
    @objc func didTapSettingsButton() {
        let svc = SettingsViewController()
//        present(svc, animated: true, completion: nil)
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    @objc func didTapFriendsButton() {
        let svc = FriendsViewController()
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    @objc private func didTapAddPhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    

}

extension TrialProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            
            let imageData = image.jpegData(compressionQuality: 0.1)
            //let strBase64 = imageData!.base64EncodedString(options: .lineLength64Characters)
            let strBase64 = imageData!.base64EncodedString()
//            let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
//            let decodedimage = UIImage(data: dataDecoded)
//            imageView.image = decodedimage
//            //print(type(of: image.pngData()))
//            //print(strBase64)
            let userRequest = SendProfilePicRequest(profilepic: strBase64)
            
            guard let request = Endpoint.setImage(userRequest: userRequest).request else {return}
            
            AuthService.fetch(request: request) { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self!.setBaseImage()
                        self!.setBackgroundBaseImage()
                    case .failure(let error):
                        guard let error = error as? ServiceError else { return }
                        
                        switch error {
                        case .serverError(let string),
                                .unkown(let string),
                                .decodingError(let string):
                            AlertManager.showSignInErrorAlert(on: self!, with: string)
                        }
                    }
                    
                }
                
            }
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true

       // make square(* must to make circle),
       // resize(reduce the kilobyte) and
       // fix rotation.
       self.image = anyImage
    }
}
