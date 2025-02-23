//
//  User.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let gender: String
    let status: Bool
}
