//
//  AuthService.swift
//  Main1
//
//  Created by yahia salman on 6/13/23.
//

import Foundation

enum ServiceError: Error {
    case serverError(String)
    case unkown(String = "An unknown error occured.")
    case decodingError(String="Error parsing server response")
}

class AuthService {
    
    static func fetch(request: URLRequest, completion: @escaping (Result<String, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                
                return
            }
            
            let decoder = JSONDecoder()
            
            if let successMessage = try? decoder.decode(SuccessResponse.self, from: data) {
                completion(.success(successMessage.success))
                return
            }
            else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: data) {
                completion(.failure(ServiceError.serverError(errorMessage.error)))
                return
            }
            else {
                completion(.failure(ServiceError.decodingError()))
            }
            return
        }.resume()
        
        
        }
    // Sign Out
    static func signOut() {
        let url = URL(string: Constants.fullURL)!
        let cookie = HTTPCookieStorage.shared.cookies(for: url)!.first!
        HTTPCookieStorage.shared.deleteCookie(cookie)
        
    }
}
