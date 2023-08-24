//
//  ShaftyViewController.swift
//  Spotify Trial
//
//  Created by yahia salman on 7/10/23.
//

import UIKit
import AVFoundation

class ShaftyViewController: UIViewController {
    let clientID = Constants.clientID
    let clientSecret = Constants.clientSecret
    let redirectURI = Constants.redirectURI
    let scope = Constants.scopes // Add required scopes here

    var webViewController: WebViewController?
    var signOutButton: UIButton!
    var displayDataButton: UIButton!
    var signInButton: UIButton!
    //var accessToken: String?
    //var refreshToken: String?
    var player: AVAudioPlayer?
    var playButton: UIButton!
    var stopButton: UIButton!
    var refreshAccessTokenButton: UIButton!
    
    private let grayBackground : UIView = {
        let grayBackground = UIView()
        grayBackground.backgroundColor = .black
        grayBackground.layer.cornerRadius = 10
        return grayBackground
    }()
    
    private let spotifyLogo: UIImageView = {
        let spotifyLogo = UIImageView()
        spotifyLogo.image = UIImage(named: "SpotifyLogo")
        return spotifyLogo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        self.setupUI()
        
        self.navigationController?.isNavigationBarHidden = false
        
        // Position the "Sign into Spotify" button
//        NSLayoutConstraint.activate([
//            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//        let customBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
//        navigationItem.leftBarButtonItem = customBackButton
        
        
        // Create and configure "Display Data" button
        displayDataButton = UIButton(type: .system)
        displayDataButton.setTitle("Display Data", for: .normal)
        displayDataButton.addTarget(self, action: #selector(displayDataButtonTapped), for: .touchUpInside)
        displayDataButton.isHidden = true
        view.addSubview(displayDataButton)
        
//        playButton = UIButton(type: .system)
//        playButton.setTitle("Pause", for: .normal)
//        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
//        playButton.frame = CGRect(x: 50, y: 100, width: 100, height: 40)
//        playButton.isHidden = true
//        view.addSubview(playButton)
//
//        stopButton = UIButton(type: .system)
//        stopButton.setTitle("Resume", for: .normal)
//        stopButton.addTarget(self, action: #selector(didTapResumeButton), for: .touchUpInside)
//        stopButton.frame = CGRect(x: 150, y: 100, width: 100, height: 40)
//        stopButton.isHidden = true
//        view.addSubview(stopButton)
//
//        refreshAccessTokenButton = UIButton(type: .system)
//        refreshAccessTokenButton.setTitle("Refresh", for: .normal)
//        refreshAccessTokenButton.addTarget(self, action: #selector(didTapRefreshAccessToken), for: .touchUpInside)
//        refreshAccessTokenButton.frame = CGRect(x: 250, y: 100, width: 100, height: 40)
//        refreshAccessTokenButton.isHidden = true
//        view.addSubview(refreshAccessTokenButton)
        
        // Position the buttons
        let buttonWidth: CGFloat = 200
        let buttonHeight: CGFloat = 40
        let buttonSpacing: CGFloat = 20
        let centerX = view.bounds.midX
        let centerY = view.bounds.midY
        
    
        
//        signOutButton.frame = CGRect(x: centerX - buttonWidth/2, y: centerY - buttonHeight/2, width: buttonWidth, height: buttonHeight)
        displayDataButton.frame = CGRect(x: centerX - buttonWidth/2, y: centerY + buttonSpacing, width: buttonWidth, height: buttonHeight)
    }
    
//    @objc private func backButtonTapped(){
//        self.navigationController?.popViewController(animated: true)
//    }
    
    
    private func setupUI() {
        
        // Create "Sign into Spotify" button
        signInButton = UIButton(type: .system)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)
        signInButton.layer.cornerRadius = 10
        signInButton.tintColor = .black
        signInButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 16)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signInButton)
        
        signOutButton = UIButton(type: .system)
        signOutButton.setTitle("Log Out", for: .normal)
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        signOutButton.isHidden = true
        signOutButton.backgroundColor = UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)
        signOutButton.layer.cornerRadius = 10
        signOutButton.tintColor = .black
        signOutButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 16)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signOutButton)
        
        
        
        view.addSubview(grayBackground)
        grayBackground.addSubview(spotifyLogo)
        
        grayBackground.translatesAutoresizingMaskIntoConstraints = false
        spotifyLogo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            grayBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            grayBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            grayBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            grayBackground.heightAnchor.constraint(equalToConstant: 60), // Set your desired height
                        
            spotifyLogo.leadingAnchor.constraint(equalTo: grayBackground.leadingAnchor, constant: 16),
            spotifyLogo.centerYAnchor.constraint(equalTo: grayBackground.centerYAnchor),
            spotifyLogo.widthAnchor.constraint(equalToConstant: 130), // Set your desired width
            spotifyLogo.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.trailingAnchor.constraint(equalTo: grayBackground.trailingAnchor, constant: -20),
            signInButton.centerYAnchor.constraint(equalTo: grayBackground.centerYAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 70),
            
            signOutButton.trailingAnchor.constraint(equalTo: grayBackground.trailingAnchor, constant: -20),
            signOutButton.centerYAnchor.constraint(equalTo: grayBackground.centerYAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 70),
        
        ])
        
        view.bringSubviewToFront(signInButton)
        view.bringSubviewToFront(signOutButton)
        
        
        
        
        
        
    }
    
    @objc func signInButtonTapped() {
        let webViewController = WebViewController(clientID: clientID, clientSecret: clientSecret, redirectURI: redirectURI, scope: scope)
        webViewController.delegate = self
        self.webViewController = webViewController
        present(webViewController, animated: true, completion: nil)
    }
    
    @objc func signOutButtonTapped() {
        // Perform the log out functionality
        guard let request = Endpoint.deleteAccessToken().request else { return }
        
        AuthService.fetch(request: request) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    break
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
        
        guard let request = Endpoint.deleteRefreshToken().request else { return }
        
        AuthService.fetch(request: request) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    break
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
        
        // Show the "Sign into Spotify" button again
        self.signInButton.isHidden = false
        signOutButton.isHidden = true
        displayDataButton.isHidden = true
    }
    
    
//    @objc func displayDataButtonTapped() {
//        fetchRecentlyPlayedSong(accessToken: getAccessToken()!)
//    }
    
    func downloadFileFromURL(url: String){
        let finalUrl = URL(string: url)
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: finalUrl!, completionHandler: {
            customURL, response, error in

            self.play(url: customURL!)

        })

        downloadTask.resume()


    }

    func play(url: URL) {

        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.prepareToPlay()
            self.player!.play()

        }
        catch{
            print(error)
        }
        
    }
    
    @objc func displayDataButtonTapped() {
        self.fetchRecentlyPlayedSong { trackPreviewURL in
            if let previewURLString = trackPreviewURL {
                self.downloadFileFromURL(url: previewURLString)
            } else {
                print("Failed to retrieve the track preview URL")
            }
        }
    }
    
    @objc func didTapRefreshAccessToken() {
        self.refreshAccessToken()
    }
    
    @objc func didTapResumeButton() {
        self.player?.play()
    }
    
    func playPreview(previewURL: URL?) {
        guard let url = previewURL else {
                print("Invalid track URI")
                return
            }
            
            let player = AVPlayer(url: url)
            player.play()
    }

    
    
    @objc func playButtonTapped() {
        self.player?.pause()
        
    }
    
    func handleAuthorizationCode(_ code: String) {
        // Perform token exchange and handle access token
        requestAccessToken(code: code)
    }
    
    func handleAccessToken(_ accessToken: String) {
        // Use the access token to make API requests
        self.signInButton.isHidden = true
        self.signOutButton.isHidden = false
        self.displayDataButton.isHidden = false
//        fetchRecentlyPlayedSong(accessToken: accessToken)
    }
    
    func storeAccessToken(_ accessToken: String) {
        
        let userRequest = SaveAccessTokenRequest(accesstoken: accessToken)
        
        guard let request = Endpoint.saveAccessToken(userRequest: userRequest).request else {return}
        
        AuthService.fetch(request: request) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    break
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
    
    func updateAccessToken(_ accessToken: String) {
        let userRequest = SaveAccessTokenRequest(accesstoken: accessToken)
        
        guard let request = Endpoint.updateAccessToken(userRequest: userRequest).request else {return}
        
        AuthService.fetch(request: request) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    break
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
    
    // Helper function to retrieve the access token from secure storage
    func getAccessToken() -> String? {
        
        var accessTokenFinal = ""
        
        AccessTokenService.getAccessToken { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let accessTokenArray):
                    accessTokenFinal = accessTokenArray.accessToken.last!
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
        return accessTokenFinal // Return the actual access token
    }
}



extension ShaftyViewController: WebViewControllerDelegate {
    func didFinishAuthorization(withCode code: String) {
        //navigationController?.popViewController(animated: true)
        handleAuthorizationCode(code)
    }
}

extension ShaftyViewController {
    // Function to exchange authorization code for access token
    func requestAccessToken(code: String) {
        let tokenURLString = "https://accounts.spotify.com/api/token"
        guard let tokenURL = URL(string: tokenURLString) else { return }
        
        // Create the request parameters
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        
        let grantType = "authorization_code"
        let codeVerifier = webViewController?.codeVerifier ?? ""
        
        let requestBody = "grant_type=\(grantType)&code=\(code)&redirect_uri=\(redirectURI)&client_id=\(clientID)&client_secret=\(clientSecret)&code_verifier=\(codeVerifier)"
        request.httpBody = requestBody.data(using: .utf8)
        
        // Create a data task to perform the token exchange request
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print("Token exchange request failed with error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let accessToken = json["access_token"] as? String,
                       let refreshToken = json["refresh_token"] as? String,
                       let expiresIn = json["expires_in"] as? Int{
                        // Handle the access token
                        print("Access token: \(accessToken.count)")
                        print("refresh token: \(refreshToken.count)")
                        print("refresh token type: \(type(of: refreshToken))")
                        print("THIS IS HOW LONG: \(expiresIn)")
                        
                        DispatchQueue.main.async {
                            self?.storeAccessToken(accessToken)
                            self?.storeRefreshToken(refreshToken: refreshToken)
                            self?.handleAccessToken(accessToken)
                            self?.webViewController?.dismiss(animated: true, completion: nil)
                            //print(self?.presentedViewController!)
                        }
                    }
                } catch {
                    print("Failed to parse JSON response: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
    // Function to fetch the most recently played song
    func fetchRecentlyPlayedSong(completion: @escaping (String?) -> Void) {
        
        
        AccessTokenService.getAccessToken { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let accessTokenArray):
                    let recentlyPlayedURLString = "https://api.spotify.com/v1/me/player/recently-played"
                    guard let recentlyPlayedURL = URL(string: recentlyPlayedURLString) else {
                        print("Invalid URL")
                        return
                    }
                    
                    var request = URLRequest(url: recentlyPlayedURL)
                    request.setValue("Bearer \(accessTokenArray.accessToken.last!)", forHTTPHeaderField: "Authorization")
                    
                    
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                            if let error = error {
                                print("Error: \(error.localizedDescription)")
                                completion(nil)
                                return
                            }
                            
                            if let data = data {
                                do {
                                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                                    if let items = json?["items"] as? [[String: Any]], let firstItem = items.first,
                                       let track = firstItem["track"] as? [String: Any],
                                       let trackName = track["name"] as? String,
                                       let previewURLString = track["preview_url"] as? String,
                                       let previewURL = URL(string: previewURLString),
                                       let trackURI = track["uri"] as? String,
                                       let trackURIURL = URL(string: trackURI){
                                        print(trackName)
                                        print("shamz")
                                        completion(previewURLString)
                                    } else {
                                        print("Failed to retrieve the track preview URL")
                                        completion(nil)
                                    }
                                } catch {
                                    print("Failed to parse JSON response: \(error.localizedDescription)")
                                    completion(nil)
                                }
                            } else {
                                completion(nil)
                            }
                        }
                    
                    task.resume()
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
                        AlertManager.showRandomAlert(on: self, error: string)
                    }
                    completion(nil)
                }
                
            }
            
            
        }
        
        
//
    }
    
    func storeRefreshToken(refreshToken: String) {
        
        let userRequest = SaveRefreshTokenRequest(refreshtoken: refreshToken)
        
        guard let request = Endpoint.saveRefreshToken(userRequest: userRequest).request else {return}
        
        AuthService.fetch(request: request) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    break
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
        
//        self.refreshToken = refreshToken
    }
    
    func refreshAccessToken() {
        
        RefreshTokenService.getRefreshToken { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let refreshTokenArray):
                    let tokenURLString = "https://accounts.spotify.com/api/token"
                    guard let tokenURL = URL(string: tokenURLString) else { return }
                    
                    // Create the request parameters
                    var request = URLRequest(url: tokenURL)
                    request.httpMethod = "POST"
                    
                    let grantType = "refresh_token"
                    
                    let requestBody = "grant_type=\(grantType)&refresh_token=\(refreshTokenArray.refreshToken.last!)&client_id=\(self.clientID)&client_secret=\(self.clientSecret)"
                    request.httpBody = requestBody.data(using: .utf8)
                    
                    // Create a data task to perform the token refresh request
                    let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                        if let error = error {
                            print("Token refresh request failed with error: \(error.localizedDescription)")
                            return
                        }
                        
                        if let data = data {
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                   let accessToken = json["access_token"] as? String {
                                    // Handle the new access token
                                    print("New access token: \(accessToken)")
                                    DispatchQueue.main.async {
                                        self?.updateAccessToken(accessToken)
                                    }
                                }
                            } catch {
                                print("Failed to parse JSON response: \(error.localizedDescription)")
                            }
                        }
                    }
                    
                    task.resume()
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
