//
//  Web2ViewController.swift
//  Spotify Trial
//
//  Created by yahia salman on 7/10/23.
//

import UIKit
import WebKit
import CommonCrypto

protocol WebViewControllerDelegate: AnyObject {
    func didFinishAuthorization(withCode code: String)
}

class WebViewController: UIViewController, WKNavigationDelegate {
    let clientID: String
    let clientSecret: String
    let redirectURI: String
    let scope: String
    
    weak var delegate: WebViewControllerDelegate?
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    var codeVerifier: String?
    
    init(clientID: String, clientSecret: String, redirectURI: String, scope: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
        self.scope = scope
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        // Position the web view to fill the entire view
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Initiate the authorization process
        authorizeWithSpotify()
    }
    
    // Function to initiate the authorization process
    func authorizeWithSpotify() {
        self.codeVerifier = generateRandomString(length: 64)
        guard let codeVerifierData = convertStringToData(codeVerifier!) else {
            print("Failed to convert code verifier to data")
            return
        }
        
        let codeChallenge = base64URLSafeEncode(data: sha256(data: codeVerifierData))
        
        let authURLString = "https://accounts.spotify.com/authorize?client_id=\(clientID)&response_type=code&redirect_uri=\(redirectURI)&scope=\(scope.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&code_challenge=\(codeChallenge)&code_challenge_method=S256"
        
        guard let authURL = URL(string: authURLString) else { return }
        
        let request = URLRequest(url: authURL)
        webView.load(request)
    }
    
    // MARK: WKNavigationDelegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        
        if url.absoluteString.starts(with: redirectURI) {
            if let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
               let queryItems = urlComponents.queryItems {
                // Extract the authorization code from the query items
                var code: String?
                for item in queryItems {
                    if item.name == "code" {
                        code = item.value
                        break
                    }
                }
                
                // Pass the authorization code to the delegate
                if let code = code {
                    delegate?.didFinishAuthorization(withCode: code)
                }
            }
        }
        
        decisionHandler(.allow)
    }
    
    // Helper function to generate a random string
    func generateRandomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = (0..<length).map { _ in characters.randomElement()! }
        return String(randomString)
    }
    
    // Helper function to calculate the SHA256 hash of the given data
    func sha256(data: Data) -> Data {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return Data(hash)
    }
    
    // Helper function to perform URL-safe Base64 encoding
    func base64URLSafeEncode(data: Data) -> String {
        var base64String = data.base64EncodedString()
        base64String = base64String.replacingOccurrences(of: "+", with: "-")
        base64String = base64String.replacingOccurrences(of: "/", with: "_")
        base64String = base64String.replacingOccurrences(of: "=", with: "")
        return base64String
    }
    
    // Helper function to verify the code verifier
    func verifyCodeVerifier(_ codeVerifier: String) -> Bool {
        let pattern = "^[a-zA-Z0-9\\-\\.\\_\\~]{43,128}$"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: codeVerifier.utf16.count)
        return regex.firstMatch(in: codeVerifier, options: [], range: range) != nil
    }
    
    func convertStringToData(_ string: String) -> Data? {
        return string.data(using: .utf8)
    }
}
