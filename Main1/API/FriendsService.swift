//
//  FriendsService.swift
//  Main1
//
//  Created by yahia salman on 7/4/23.
//

import Foundation

class FriendsService {
    static func getFriends(completion: @escaping (Result<FriendsArray, Error>) -> Void) {
        
        guard let request = Endpoint.getFriends().request else { return }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let friends = data else {
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                
                return
            }
            
            let decoder = JSONDecoder()
            
            if let array = try? decoder.decode(FriendsArray.self, from: friends) {
                completion(.success(array))
                return
            }
            else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: friends) {
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

