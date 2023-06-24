//
//  ImageService.swift
//  Main1
//
//  Created by yahia salman on 6/20/23.
//

import Foundation

class ImageService {
    static func getImage(completion: @escaping (Result<ProfilePicsArray, Error>) -> Void) {
        
        guard let request = Endpoint.getImage().request else { return }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let image = data else {
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                
                return
            }
            
            let decoder = JSONDecoder()
            
            if let array = try? decoder.decode(ProfilePicsArray.self, from: image) {
                completion(.success(array))
                return
            }
            else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: image) {
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
