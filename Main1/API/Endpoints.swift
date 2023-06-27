//
//  Endpoints.swift
//  Main1
//
//  Created by yahia salman on 6/12/23.
//

import Foundation

enum Endpoint {
    
    case createAccount(path: String = "/auth/create-account", userRequest: RegisterUserRequest)
    case signIn(path: String = "/auth/sign-in", userRequest: SignInUserRequest)
    case forgotPassword(path: String = "/auth/forgot-password", email: String)
    
    case getData(path: String = "/data/get-data")
    case getImage(path: String = "/data/get-image")
    case getUsername(path: String = "/data/get-username")
    case getEmail(path: String = "/data/get-email")
    case setData(path: String = "/data/set-data", userRequest: SendDataRequest)
    case setImage(path: String = "/data/set-image", userRequest: SendProfilePicRequest)
    case requestFriend(path: String = "/data/request-friend", userRequest: FriendRequestRequest)
    
    var request: URLRequest? {
        guard let url = self.url else {return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.addValues(for: self)
        request.httpBody = self.httpBody
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        return components.url
    }
    
    private var path: String {
        switch self {
        case .createAccount(let path, _),
                .signIn(let path, _),
                .forgotPassword(let path, _),
                .getData(let path),
                .getImage(let path),
                .getUsername(let path),
                .getEmail(let path),
                .setData(let path, _),
                .setImage(let path, _),
                .requestFriend(let path, _):
            return path
        }
    }
    
    private var httpMethod: String {
        switch self {
        case.createAccount,
                .signIn,
                .forgotPassword,
                .setData,
                .setImage,
                .requestFriend:
            return HTTP.Method.post.rawValue
        case .getData,
                .getImage,
                .getUsername,
                .getEmail:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .createAccount(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
            
        case.signIn(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
            
        case.forgotPassword(_, let email):
            return try? JSONSerialization.data(withJSONObject: ["email": email], options: [])
        case .getData:
            return nil
        case .requestFriend(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .getImage:
            return nil
        case .setData(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .setImage(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .getUsername:
            return nil
        case .getEmail:
            return nil
        }
    
        
    }
}

extension URLRequest {
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint{
        case .createAccount,
                .signIn,
                .forgotPassword,
                .getData,
                .setData,
                .getImage,
                .setImage,
                .getUsername,
                .getEmail,
                .requestFriend:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        }
        
    }
}
