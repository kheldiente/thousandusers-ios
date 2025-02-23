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
    
    @Published 
    var uiState: UserListUiState = UserListUiState()
    
    private let userDataSource: UserDataSource
    
    init(dataSource: UserDataSource) {
        self.userDataSource = dataSource
        
        loadInitData()
    }
    
    func loadInitData() {
        Task {
            await userDataSource.populateDatabaseIfNeeded()
            let usersFromFile = try await userDataSource.getUsers(limit: 5, offset: 0)
            
            uiState.users = usersFromFile
        }
    }
    
    func loadMoreUsers() {
        
    }
    
}
