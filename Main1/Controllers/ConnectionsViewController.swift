//
//  ShaftyViewController.swift
//  Spotify Trial
//
//  Created by yahia salman on 7/10/23.
//

import UIKit
import AVFoundation

class ShaftyViewController: UIViewController {
    let clientID = "777bedff1a84486385f035d407b5f7fa"
    let clientSecret = "b925af27890344d0935688f9715b20e7"
    let redirectURI = "https://www.google.com"
    let scope = "user-read-private user-read-email user-read-recently-played streaming" // Add required scopes here

    var webViewController: WebViewController?
    var signOutButton: UIButton!
    var displayDataButton: UIButton!
    var signInButton: UIButton!
    var accessToken: String?
    var refreshToken: String?
    var player: AVAudioPlayer?
    var playButton: UIButton!
    var stopButton: UIButton!
    var refreshAccessTokenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 41/255, green: 37/255, blue: 44/255, alpha: 1)
        
        // Create "Sign into Spotify" button
        signInButton = UIButton(type: .system)
        signInButton.setTitle("Sign into Spotify", for: .normal)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signInButton)
        
        // Position the "Sign into Spotify" button
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        signOutButton = UIButton(type: .system)
        signOutButton.setTitle("Log out of Spotify", for: .normal)
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        signOutButton.isHidden = true
        view.addSubview(signOutButton)
        
        // Create and configure "Display Data" button
        displayDataButton = UIButton(type: .system)
        displayDataButton.setTitle("Display Data", for: .normal)
        displayDataButton.addTarget(self, action: #selector(displayDataButtonTapped), for: .touchUpInside)
        displayDataButton.isHidden = true
        view.addSubview(displayDataButton)
        
        playButton = UIButton(type: .system)
        playButton.setTitle("Pause", for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        playButton.frame = CGRect(x: 50, y: 100, width: 100, height: 40)
        view.addSubview(playButton)
        
        stopButton = UIButton(type: .system)
        stopButton.setTitle("Resume", for: .normal)
        stopButton.addTarget(self, action: #selector(didTapResumeButton), for: .touchUpInside)
        stopButton.frame = CGRect(x: 150, y: 100, width: 100, height: 40)
        view.addSubview(stopButton)
        
        refreshAccessTokenButton = UIButton(type: .system)
        refreshAccessTokenButton.setTitle("Refresh", for: .normal)
        refreshAccessTokenButton.addTarget(self, action: #selector(didTapRefreshAccessToken), for: .touchUpInside)
        refreshAccessTokenButton.frame = CGRect(x: 250, y: 100, width: 100, height: 40)
        view.addSubview(refreshAccessTokenButton)
        
        // Position the buttons
        let buttonWidth: CGFloat = 200
        let buttonHeight: CGFloat = 40
        let buttonSpacing: CGFloat = 20
        let centerX = view.bounds.midX
        let centerY = view.bounds.midY
        
    
        
        signOutButton.frame = CGRect(x: centerX - buttonWidth/2, y: centerY - buttonHeight/2, width: buttonWidth, height: buttonHeight)
        displayDataButton.frame = CGRect(x: centerX - buttonWidth/2, y: centerY + buttonSpacing, width: buttonWidth, height: buttonHeight)
    }
    
    @objc func signInButtonTapped() {
        let webViewController = WebViewController(clientID: clientID, clientSecret: clientSecret, redirectURI: redirectURI, scope: scope)
        webViewController.delegate = self
        self.webViewController = webViewController
        present(webViewController, animated: true, completion: nil)
        
        
//        let webViewController = WebViewController()
        //        webViewContainer = webViewController
        //        webViewController.delegate = self
        //        present(webViewController, animated: true, completion: nil)
    }
    
    @objc func signOutButtonTapped() {
        // Perform the log out functionality
        self.accessToken = nil
        
        // Show the "Sign into Spotify" button again
        self.signInButton.isHidden = false
        signOutButton.isHidden = true
        displayDataButton.isHidden = true
    }
    
//    @objc func displayDataButtonTapped() {
//        fetchRecentlyPlayedSong(accessToken: getAccessToken()!)
//    }
    
    func downloadFileFromURL(url: URL){
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
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
        fetchRecentlyPlayedSong { trackPreviewURL in
            if let previewURL = trackPreviewURL {
                // Play the preview URL
                print(previewURL)
//                self.playPreview(previewURL: previewURL)
                self.downloadFileFromURL(url: previewURL)
            } else {
                print("Failed to retrieve the track preview URL")
            }
        }
//        fetchRecentlyPlayedSong { [weak self] (trackURI) in
//                if let trackURI = trackURI {
//                    self?.playPreview(trackURI: trackURI)
//                } else {
//                    print("Failed to retrieve track URI")
//                }
//            }
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
        self.accessToken = accessToken
//        print(accessToken)
        
    }
    
    // Helper function to retrieve the access token from secure storage
    func getAccessToken() -> String? {
        // Implement your logic to retrieve the access token from secure storage
        // ...
        return self.accessToken // Return the actual access token
    }
    
    func getRecentlyPlayedSongURL(completion: @escaping (URL?) -> Void) {
        guard let accessToken = getAccessToken() else {
            print("Access token is missing")
            completion(nil)
            return
        }
        
        let recentlyPlayedURLString = "https://api.spotify.com/v1/me/player/recently-played"
        guard let recentlyPlayedURL = URL(string: recentlyPlayedURLString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: recentlyPlayedURL)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
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
                       let previewURLString = track["preview_url"] as? String,
                       let previewURL = URL(string: previewURLString) {
                        completion(previewURL)
                    } else {
                        print("No recently played songs found")
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
                        print("Access token: \(accessToken)")
                        print("refresh token: \(refreshToken)")
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
    func fetchRecentlyPlayedSong(completion: @escaping (URL?) -> Void) {
        guard let accessToken = self.getAccessToken() else {
            print("Access token is missing")
            completion(nil)
            return
        }
        
        let recentlyPlayedURLString = "https://api.spotify.com/v1/me/player/recently-played"
        guard let recentlyPlayedURL = URL(string: recentlyPlayedURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: recentlyPlayedURL)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            if let data = data {
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                       let items = json["items"] as? [[String: Any]],
//                       let firstItem = items.first,
//                       let track = firstItem["track"] as? [String: Any],
//                       let trackName = track["name"] as? String,
//                       let artists = track["artists"] as? [[String: Any]],
//                       let firstArtist = artists.first,
//                       let artistName = firstArtist["name"] as? String {
//
//                        // Print the most recently played song
//                        print("Most recently played song:")
//                        print("Track: \(trackName)")
//                        print("Artist: \(artistName)")
//                    }
//                } catch {
//                    print("Failed to parse JSON response: \(error.localizedDescription)")
//                }
//            }
//        }
        
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
                            completion(previewURL)
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
    }
    
    func storeRefreshToken(refreshToken: String) {
        self.refreshToken = refreshToken
    }
    
    func refreshAccessToken() {
        guard let refreshToken = self.refreshToken else {
            print("Refresh token not available.")
            return
        }
        
        let tokenURLString = "https://accounts.spotify.com/api/token"
        guard let tokenURL = URL(string: tokenURLString) else { return }
        
        // Create the request parameters
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        
        let grantType = "refresh_token"
        
        let requestBody = "grant_type=\(grantType)&refresh_token=\(refreshToken)&client_id=\(clientID)&client_secret=\(clientSecret)"
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
                            self?.storeAccessToken(accessToken)
                        }
                    }
                } catch {
                    print("Failed to parse JSON response: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }

}
