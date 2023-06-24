//
//  LoginPageViewController.swift
//  Main1
//
//  Created by yahia salman on 5/2/23.
//

import UIKit

class LoginPageViewController: UIViewController {
     
    // UI Components
    private let primaryPurpColor: UIColor = {
        let primaryPurpColor = UIColor(red: 82/225, green: 65/225, blue: 147/225, alpha: 1)
        return primaryPurpColor
    }()
    
    private let primaryRedColor: UIColor = {
        let primaryRedColor = UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1)
        return primaryRedColor
    }()
    
    public var admin: Bool = false
    
    
    
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontsize: .big, buttonColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1), titleColor: .white, cornerRadius: 10)
    private let newUserButton = CustomButton(title: "New User? Create Account", fontsize: .small, buttonColor: .systemBackground, titleColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1))
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontsize: .small, buttonColor: .systemBackground, titleColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1))
    
    
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    //UI Setup
    
    private func setupUI() {
        
        self.view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        //self.view.backgroundColor = .systemBackground
        
        
        signInButton.tintColor = UIColor(red: 82/255, green: 65/255, blue: 147/255, alpha: 1)
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(newUserButton)
        self.view.addSubview(forgotPasswordButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField .translatesAutoresizingMaskIntoConstraints = false
        passwordField .translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton .translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant:222),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 45),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            self.passwordField.centerXAnchor.constraint(equalTo: emailField.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 45),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85),
            
            self.forgotPasswordButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 1),
//            self.forgotPasswordButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            forgotPasswordButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 23),
            self.forgotPasswordButton.widthAnchor.constraint(equalToConstant: 130),
            
            
            self.signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 12),
            self.signInButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 45),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85),
            
            self.newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 12),
            //if we want at bottom make constant 290
            self.newUserButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            self.newUserButton.heightAnchor.constraint(equalToConstant: 44),
            self.newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85)
            
//            self.forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 6),
//            self.forgotPasswordButton.centerXAnchor.constraint(equalTo: newUserButton.centerXAnchor),
//            self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
//            self.forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85)
        ])
    }
    
    
    @objc private func didTapSignIn() {
        let userRequest = SignInUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        if (userRequest.email == "info.rybum@gmail.com"){
            isAdmin.admin = true
        }
        else {
            isAdmin.admin = false
        }
        
        print(isAdmin.admin)
        
        
        //Email Check
        if !Validator.isValidEmail(for: userRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        //Password Check
        if !Validator.isPasswordValid(for: userRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        guard let request = Endpoint.signIn(userRequest: userRequest).request else {return}
        
        AuthService.fetch(request: request) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.checkAuthentication()
                    }
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
        
        //        print("HI")
        //        let webViewer = WebViewerController(with: "https://www.fortnite.com/?lang=en-US")
        //
        //        let nav = UINavigationController(rootViewController: webViewer)
        //        self.present(nav, animated: true, completion: nil)
        //let vc = HomeViewController()
        //        let tabBarVC = UITabBarController()
        //        let tabBarVCTemp = MainTabBarViewController()
        //
        //        let vc1 = UINavigationController(rootViewController: HomeViewController())
        //        let vc2 = UINavigationController(rootViewController: FriendsViewController())
        //        let vc4 = UINavigationController(rootViewController: ProfileViewController())
        //        let vc3 = UINavigationController(rootViewController: CameraViewController())
        //
        //        vc1.tabBarItem.image = UIImage(systemName: "music.note")
        //        vc2.tabBarItem.image = UIImage(systemName: "person.3")
        //        vc3.tabBarItem.image = UIImage(systemName: "camera")
        //        vc4.tabBarItem.image = UIImage(systemName: "person.circle")
        //
        //        vc1.title = "Bytes"
        //        vc2.title = "Friends"
        //        vc3.title = "Camera"
        //        vc4.title = "Profile"
        //
        //
        //        tabBarVC.tabBar.tintColor = .label
        //
        //        tabBarVC.tabBar.backgroundColor = .secondarySystemBackground
        //
        //        tabBarVC.setViewControllers([vc1, vc2, vc4, vc3], animated: true)
        //
        //        tabBarVCTemp.modalPresentationStyle = .fullScreen
        //        self.present(tabBarVCTemp, animated: false, completion: nil)
    }
    
    @objc private func didTapNewUser() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPassword() {
        let vc = ForgotPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
