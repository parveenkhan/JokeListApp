//
//  AppError.swift
//  JokeListApp
//
//  Created by Parveen Khan on 04/05/23.
//

import Foundation


/// App Network error
enum NetworkError {
    case parsing
    case notFound
    case requestFailed
    case custom(errorCode: Int?, errorDescription: String?)
}

extension NetworkError {
    var errorDescription: String? {
        switch self {
        case .parsing: return "Parsing error"
        case .notFound: return "URL Not Found"
        case .requestFailed: return "Error: Jokes GET Request failed"
        case .custom(_, let errorDescription): return errorDescription
        }
    }
}
