//
//  SearchViewController.swift
//  Main1
//
//  Created by yahia salman on 4/26/23.
//

import UIKit

class ProfileViewController: UIViewController {

    
    private let settingsButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.backgroundColor = .systemBackground
        settingsButton.layer.cornerRadius = 7
        settingsButton.frame = CGRect(x: 350, y: 85, width: 44, height: 44)
        settingsButton.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        return settingsButton
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 0
        return label
    }()
    
    //var dataArray : DataArray
    
    init(dataArray: DataArray) {
        //self.dataArray = dataArray
        super.init(nibName: nil, bundle: nil)
        self.label.text = ""
        dataArray.data.forEach({ self.label.text?.append("\n\($0)")})
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let addDataField = CustomTextField(fieldType: .email)
    private let chins = CustomButton(title: "Submit", fontsize: .med, buttonColor: .systemRed)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        self.chins.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        
        
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        
        self.view.addSubview(label)
        self.view.addSubview(addDataField)
        self.view.addSubview(chins)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addDataField.translatesAutoresizingMaskIntoConstraints = false
        chins.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.addDataField.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 45),
            self.addDataField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.addDataField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.addDataField.heightAnchor.constraint(equalToConstant:45),
            
            self.chins.topAnchor.constraint(equalTo: addDataField.bottomAnchor, constant: 12),
            self.chins.centerXAnchor.constraint(equalTo: addDataField.centerXAnchor),
            self.chins.heightAnchor.constraint(equalToConstant: 45),
            self.chins.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.85),
            
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        self.view.addSubview(settingsButton)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
               
        let largeBoldDoc = UIImage(systemName: "gear.circle", withConfiguration: largeConfig)
        
        settingsButton.setImage(largeBoldDoc, for: .normal)
        
        
        
        self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //settingsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //settingsButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            //settingsButton.widthAnchor.constraint(equalToConstant: 700),
            //settingsButton.heightAnchor.constraint(equalToConstant: 180),
            settingsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            settingsButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90)
        ])
    }
    
    @objc func didTapSettingsButton() {
        let svc = SettingsViewController()
        present(svc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    @objc func didTapSubmitButton() {
        if (self.addDataField.text != "" && self.addDataField.text!.count < 15) {
            let userRequest = SendDataRequest(data: self.addDataField.text ?? "")
            
            guard let request = Endpoint.setData(userRequest: userRequest).request else {return}
            
            AuthService.fetch(request: request) { [weak self] result in
                
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(_):
//                        self.label.text = ""
//                        self.dataArray.data.forEach({ self.label.text?.append("\n\($0)")})
//                        self.label.text?.append("\n\(self.dataArray.data[0])")
                        DataService.getData { [weak self] result in
                            
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let dataArray):
                                    
                                    self!.label.text = ""
//                                    dataArray.data.forEach({self!.label.text?.append("\n\($0)")})
                                    self!.label.text?.append("\n\(dataArray.data.last!)")
                                    self!.addDataField.text = ""
                                case .failure(_):
                                    break
                                }
                            }
                            
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
        } else {
            AlertManager.showRandomAlert(on: self, error: "Empty field idiot")
        }
            
        
    }
    


}
