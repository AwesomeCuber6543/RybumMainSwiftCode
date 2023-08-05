//
//  AccessTokenService.swift
//  Main1
//
//  Created by yahia salman on 8/4/23.
//

import Foundation

class AccessTokenService {
    static func getAccessToken(completion: @escaping (Result<AccessTokenArray, Error>) -> Void) {
        
        guard let request = Endpoint.getAccessToken().request else { return }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let accessToken = data else {
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                
                return
            }
            
            let decoder = JSONDecoder()
            
            if let array = try? decoder.decode(AccessTokenArray.self, from: accessToken) {
                completion(.success(array))
                return
            }
            else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: accessToken) {
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
