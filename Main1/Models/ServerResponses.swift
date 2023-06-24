//
//  ServerResponses.swift
//  Main1
//
//  Created by yahia salman on 6/12/23.
//

import Foundation

struct SuccessResponse: Decodable {
    let success: String
}

struct ErrorResponse: Decodable {
    let error: String
}
