//
//  UserListViewModel.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation
import Combine

@MainActor
class UserListViewModel: ObservableObject {
    
    @Published var uiState: UserListUiState = UserListUiState()
    
    private let userDataSource: UserDataSource = UserRepository()
    
    init() {
        uiState.users.append(
            User(id: 1, firstName: "John", lastName: "Doe", email: "johndoe@gmail.com", gender: "Male", status: false)
        )
        uiState.users.append(
            User(id: 2, firstName: "Mary", lastName: "Doe", email: "marydoe@gmail.com", gender: "Female", status: false)
        )
    }
    
    func loadUsers() {
        Task {
            let usersFromFile = await userDataSource.getUsers()
            uiState.users = usersFromFile
        }
    }
    
}
