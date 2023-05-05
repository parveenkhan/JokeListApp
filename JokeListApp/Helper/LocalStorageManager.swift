//
//  LocalStorageManager.swift
//  JokeListApp
//
//  Created by Parveen Khan on 04/05/23.
//

import Foundation


/// A constant string as a key to save and retrieve data from userdefaults
enum localStorageKey: String{
    case jokesList = "jokesList"
}

/// A protocol/Interface for the userdefaults manager
protocol LocalStorageManagerProtocol {
    
    static func setLocalJokes(_ array: [JokeModel])
    static func getLocalJokes() -> [JokeModel]
}

struct LocalStorageManager: LocalStorageManagerProtocol {
    
    static let userDefaults = UserDefaults.standard
    
    /// to save the jokes array in userdefaults
    /// - Parameter array: An Array of JokeModel
    static func setLocalJokes(_ array: [JokeModel]) {
        do {
            let encodedData = try JSONEncoder().encode(array)
            userDefaults.set(encodedData, forKey: localStorageKey.jokesList.rawValue)
            
        } catch {
            print("Failed to encode Jokes to Data")
        }
        
    }
    
    /// to retrieve the jokes data from userdefaults
    /// - Returns: An array of jokeModel
    static func getLocalJokes() -> [JokeModel] {
        if let savedData = userDefaults.object(forKey: localStorageKey.jokesList.rawValue) as? Data {
            
            do{
                let savedJokes = try JSONDecoder().decode([JokeModel].self, from: savedData)
                return savedJokes
                
            } catch {
                print("Failed to convert Data to Jokes")
            }
        }
        return []
        
    }
}
