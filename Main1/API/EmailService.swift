//
//  EmailService.swift
//  Main1
//
//  Created by yahia salman on 6/23/23.
//

import Foundation

class EmailService {
    static func getEmail(completion: @escaping (Result<EmailArray, Error>) -> Void) {
        
        guard let request = Endpoint.getEmail().request else { return }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let returnedEmail = data else {
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                
                return
            }
            
            let decoder = JSONDecoder()
            
            if let array = try? decoder.decode(EmailArray.self, from: returnedEmail) {
                completion(.success(array))
                return
            }
            else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: returnedEmail) {
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

