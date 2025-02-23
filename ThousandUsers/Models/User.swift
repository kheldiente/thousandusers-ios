//
//  User.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int32
    let firstName: String
    let lastName: String
    let email: String
    let gender: String
    let status: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case gender = "gender"
        case status = "status"
    }
}
