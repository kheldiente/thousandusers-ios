//
//  UserListItemView.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation
import SwiftUI

struct UserListItemView: View {
    
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(user.firstName) \(user.lastName)")
                .font(.headline)
            Text("ID: \(user.id)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Email: \(user.email)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Gender: \(user.gender)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Status: \(user.status ? "Active" : "Inactive")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
}
