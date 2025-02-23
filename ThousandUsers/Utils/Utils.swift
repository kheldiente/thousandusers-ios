//
//  Utils.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation

enum JSONError: Error {
    case fileNotFound
    case decodingError(Error)
}

struct Utils {
    
    static let fileName = "thousand_users"
    
    static func loadUsersfromJSON() async throws -> [User] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw JSONError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode([User].self, from: data)
            return response
        } catch {
            throw JSONError.decodingError(error)
        }
    }
    
}
