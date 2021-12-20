//
//  NetworkError.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 02/12/2021.
//

import Foundation

enum NetworkError: Error {
    case invalidURL, noData, invalidResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidURL: return "The service is momentarily unavailable"
        case .noData: return "The service is momentarily unavailable"
        case .invalidResponse: return "The service is momentarily unavailable"
        case .undecodableData: return "The service is momentarily unavailable"
        }
    }
}
