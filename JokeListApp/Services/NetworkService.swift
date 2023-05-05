//
//  NetworkService.swift
//  JokeListApp
//
//  Created by Parveen Khan on 04/05/23.
//

import Foundation

protocol JokeServiceProtocol {
    func getJoke(completion: @escaping (_ success: Bool, _ results: JokeModel?, _ error: NetworkError?) -> ())
}

class JokeService: JokeServiceProtocol {
    
    func getJoke(completion: @escaping (Bool, JokeModel?, NetworkError?) -> ()) {
        HttpRequestHelper().GET(url: JokesApiUrl.getJokes, params: ["": ""], httpHeader: .application_json) { success, data in
        
            if success {
                if let resultString = String(data: data!, encoding: .utf8) {
                    
                    completion(true, JokeModel(jokeMessage: resultString.messageFormat()), nil)
                } else {
                    completion(false, nil, .parsing)
                }

            } else {
                completion(false, nil, .requestFailed)
            }
        }
    }
}
