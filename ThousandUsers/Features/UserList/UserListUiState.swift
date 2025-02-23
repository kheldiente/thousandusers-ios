//
//  UserListUiState.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation

struct UserListUiState {
    var users: [User] = []
    var isLoading: Bool = false
    var hasMoreUsers: Bool = false
    var isLoadingMoreUsers: Bool = false
}
