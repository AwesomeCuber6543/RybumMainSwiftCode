//
//  AlertManager.swift
//  Main1
//
//  Created by yahia salman on 5/21/23.
//

import UIKit

class AlertManager {
    
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

// Show Valudatino Alerts
extension AlertManager {
    
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email.")
    }
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Password", message: "Please enter a valid password.")
    }
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Username", message: "Please enter a valid username.")
    }
    
}
// Registration Errors
extension AlertManager {
    
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: String) {
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: "\(error)")
    }
    
    
}

// Log in Errors
extension AlertManager {
    
    public static func showSignInErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unknown Error Signing In", message: nil)
    }
    
    public static func showSignInErrorAlert(on vc: UIViewController, with error: String) {
        self.showBasicAlert(on: vc, title: "Error Signing In", message: "\(error)")
    }
    
    
    
}

// Log out Errors
extension AlertManager {
    
    
    public static func showLogoutError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Log Out Error", message: "\(error.localizedDescription)")
    }
    
}

//forgot password

extension AlertManager{
    
    public static func showPasswordResetSent(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Password Reset Sent", message: nil)
    }
    
    public static func showErrorSendingPasswordReset(on vc: UIViewController, with error: String) {
        self.showBasicAlert(on: vc, title: "Error Sending Password Reset", message: "\(error)")
    }
}


//Fetching user errors
extension AlertManager{
    public static func showFetchingUserError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
    
    public static func showUnknownFetchingUserError(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unknown Error Fetching User", message: nil)
    }
}

//Random Alert
extension AlertManager{
    public static func showRandomAlert(on vc: UIViewController, error: String){
        self.showBasicAlert(on: vc, title: "UH OH", message: error)
    }
    
}

//Friend Request Errors
extension AlertManager {
    
    public static func showFriendRequestError(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Error Sending Friend Request", message: nil)
    }
    
    public static func showFriendRequestError(on vc: UIViewController, with error: String) {
        self.showBasicAlert(on: vc, title: "Error Sending Friend Request", message: "\(error)")
    }
    
    public static func getFriendRequestError(with error: String) -> String {
        return error
    }
    
    
    
}
