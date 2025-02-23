//
//  UserRepository.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation

protocol UserDataSource {
    func getUsers() async -> [User]
}

class UserRepository: UserDataSource {
    
    func getUsers() async -> [User] {
        do {
            let users = try await Utils.loadUsersfromJSON()
            return Array(users.prefix(10))
        } catch {
            print(error)
        }
        return []
    }
    
}
