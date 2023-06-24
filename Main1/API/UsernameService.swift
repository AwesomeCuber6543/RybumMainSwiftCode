//
//  UsernameService.swift
//  Main1
//
//  Created by yahia salman on 6/23/23.
//

import Foundation

class UsernameService {
    static func getUsername(completion: @escaping (Result<UsernameArray, Error>) -> Void) {
        
        guard let request = Endpoint.getUsername().request else { return }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let username = data else {
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                
                return
            }
            
            let decoder = JSONDecoder()
            
            if let array = try? decoder.decode(UsernameArray.self, from: username) {
                completion(.success(array))
                return
            }
            else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: username) {
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

