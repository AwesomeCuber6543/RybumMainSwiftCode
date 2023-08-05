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
    case getFriendRequests(path: String = "/data/get-friendrequests")
    case getFriends(path: String = "/data/get-friends")
    case getImageFromUsername(path: String = "/data/get-imagefromusername", userRequest: FriendProfPicRequest)
    case deleteFriend(path: String = "/data/delete-friend", userRequest: DeleteFriendRequest)
    
    case saveAccessToken(path: String = "/data/set-accesstoken", userRequest: SaveAccessTokenRequest)
    case saveRefreshToken(path: String = "/data/set-refreshtoken", userRequest: SaveRefreshTokenRequest)
    case getAccessToken(path: String = "/data/get-accesstoken")
    case getRefreshToken(path: String = "/data/get-refreshtoken")
    case updateAccessToken(path: String = "/data/update-accesstoken", userRequest: SaveAccessTokenRequest)
    case updateRefreshToken(path: String = "/data/update-refreshtoken", userRequest: SaveRefreshTokenRequest)
    
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
                .requestFriend(let path, _),
                .getFriendRequests(let path),
                .getFriends(let path),
                .getImageFromUsername(let path, _),
                .deleteFriend(let path, _),
                .getAccessToken(let path),
                .getRefreshToken(let path),
                .saveAccessToken(let path, _),
                .saveRefreshToken(let path, _),
                .updateRefreshToken(let path, _),
                .updateAccessToken(let path, _):
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
                .requestFriend,
                .getImageFromUsername,
                .deleteFriend,
                .saveAccessToken,
                .saveRefreshToken,
                .updateAccessToken,
                .updateRefreshToken:
            return HTTP.Method.post.rawValue
        case .getData,
                .getImage,
                .getUsername,
                .getEmail,
                .getFriendRequests,
                .getFriends,
                .getAccessToken,
                .getRefreshToken:
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
        case .deleteFriend(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .getImage:
            return nil
        case .setData(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .setImage(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .getUsername:
            return nil
        case .getImageFromUsername(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .getEmail:
            return nil
        case .getFriendRequests:
            return nil
        case .getFriends:
            return nil
        case .getAccessToken:
            return nil
        case .getRefreshToken:
            return nil
        case .saveAccessToken(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .saveRefreshToken(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .updateAccessToken(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
        case .updateRefreshToken(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
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
                .requestFriend,
                .getFriendRequests,
                .getFriends,
                .getImageFromUsername,
                .deleteFriend,
                .getAccessToken,
                .getRefreshToken,
                .saveAccessToken,
                .saveRefreshToken,
                .updateAccessToken,
                .updateRefreshToken:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        }
        
    }
}
