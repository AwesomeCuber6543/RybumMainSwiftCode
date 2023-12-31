//
//  RegisterViewController.swift
//  Main1
//
//  Created by yahia salman on 5/2/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // UI Components
    
    private let headerView = AuthHeaderView(title: "Sign Up", subTitle: "Create your account")
    
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    
    
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontsize: .big, buttonColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1), titleColor: .white
    )
    private let signInButton = CustomButton(title: "Already have an account? Sign In.", fontsize: .small, buttonColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1), titleColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1))
    
    private let termsTextView: UITextView = {
        
        let attributedString = NSMutableAttributedString(string: "By creating an account, you agree to our Terms & Conditions and you ackniwledge that you have read our Privacy Policy")
        
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let tv = UITextView()
        
        tv.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 65/255, blue: 54/255, alpha: 1)]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = .white
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.termsTextView.delegate = self
        
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround() 
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    //UI Setup
    
    private func setupUI() {
        
        self.view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        
        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(termsTextView)
        self.view.addSubview(signInButton)
        
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.usernameField.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.termsTextView.translatesAutoresizingMaskIntoConstraints = false
        self.signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant:222),
            
            self.usernameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            self.usernameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.usernameField.heightAnchor.constraint(equalToConstant: 45),
            self.usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 12),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 45),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 45),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85),
            
            self.signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 12),
            self.signUpButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 45),
            self.signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85),
            
            self.termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 6),
            self.termsTextView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.termsTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85),
            
//            self.signInButton.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 225),
            self.signInButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 100),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 44),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85)
            
        ])
    }
    
    @objc func didTapSignUp() {
        let userRequest = RegisterUserRequest(
            email: self.emailField.text ?? "",
            username: self.usernameField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        //Username Check
        if !Validator.isValidUsername(for: userRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
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
        guard let request = Endpoint.createAccount(userRequest: userRequest).request else {return}
        
        AuthService.fetch(request: request) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    let baseImage = UIImage(named: "rybumskinnylogo")
                    let imageData = baseImage!.jpegData(compressionQuality: 0.1)
                    let strBase64 = imageData!.base64EncodedString()
                    let userRequest = SendProfilePicRequest(profilepic: strBase64)
                    
                    guard let request = Endpoint.setImage(userRequest: userRequest).request else {return}
                    
                    AuthService.fetch(request: request) { [weak self] result in
                        
                        DispatchQueue.main.async {
                            switch result {
                            case .success(_):
                                break
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
                    
                    
                    
                    if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.checkAuthentication()
                    }
                    
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
                        AlertManager.showRegistrationErrorAlert(on: self, with: string)
                    }
                }
                
            }
            
            
            
        }
        
//        print("HI")
//        let webViewer = WebViewerController(with: "https://www.fortnite.com/?lang=en-US")
//
//        let nav = UINavigationController(rootViewController: webViewer)
//        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func didTapSignIn() {
        //let vc = HomeViewController()
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    

}

extension RegisterViewController: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms" {
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=en")
        } else if URL.scheme == "privacy" {
            self.showWebViewerController(with: "https://policies.google.com/privacy?hl=en")
        }
        
        
        return true
    }
    
    private func showWebViewerController(with urlString: String) {
        let vc = WebViewerController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}
