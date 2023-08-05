//
//  RefreshTokenService.swift
//  Main1
//
//  Created by yahia salman on 8/4/23.
//

import Foundation

class RefreshTokenService {
    static func getRefreshToken(completion: @escaping (Result<RefreshTokenArray, Error>) -> Void) {
        
        guard let request = Endpoint.getRefreshToken().request else { return }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let refreshToken = data else {
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            if let array = try? decoder.decode(RefreshTokenArray.self, from: refreshToken) {
                completion(.success(array))
                return
            }
            else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: refreshToken) {
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
