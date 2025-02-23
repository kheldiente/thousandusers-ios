//
//  UserListViewModel.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation
import Combine

class UserListViewModel: ObservableObject {
    
    @Published var uiState: UserListUiState = UserListUiState()
    
    init() {
        uiState.users.append(
            User(id: 1, firstName: "John", lastName: "Doe", email: "johndoe@gmail.com", gender: "Male", status: false)
        )
        uiState.users.append(
            User(id: 2, firstName: "Mary", lastName: "Doe", email: "marydoe@gmail.com", gender: "Female", status: false)
        )
    }
    
    func loadUsers() {
        // Check if to load next page
    }
    
}
