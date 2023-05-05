//
//  String+Extension.swift
//  JokeListApp
//
//  Created by Parveen Khan on 04/05/23.
//

import Foundation

extension String {
    
    /// to set the custom format of message string
    /// - Returns: custom formatted string
    func messageFormat() -> String {
     return self.replacingOccurrences(of: "\"", with: "")
    }
}
