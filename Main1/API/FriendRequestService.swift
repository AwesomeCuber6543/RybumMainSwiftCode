//
//  FriendRequestService.swift
//  Main1
//
//  Created by yahia salman on 6/26/23.
//

import Foundation

class FriendRequestService {
    static func getFriendRequest(completion: @escaping (Result<EmailArray, Error>) -> Void) {
        
        guard let request = Endpoint.getEmail().request else { return }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let friendRequests = data else {
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                
                return
            }
            
            let decoder = JSONDecoder()
            
            if let array = try? decoder.decode(EmailArray.self, from: friendRequests) {
                completion(.success(array))
                return
            }
            else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: friendRequests) {
                completion(.failure(ServiceError.serverError(errorMessage.error)))
                return
            }
            else {
                completion(.failure(ServiceError.decodingError()))
            }
            return
        }.resume()
        
    }
}

