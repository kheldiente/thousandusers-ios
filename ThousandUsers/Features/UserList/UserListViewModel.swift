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
    private var currentPage = Constants.initPage
    private var maxUserCount = 0
    
    init(dataSource: UserDataSource) {
        userDataSource = dataSource
        populateDbIfNeeded()
        loadInitData()
    }
    
    private func populateDbIfNeeded() {
        Task {
            await userDataSource.populateDatabaseIfNeeded()
        }
    }
    
    func loadInitData() {
        Task {
            uiState.isLoading = true
            try await Task.sleep(for: .milliseconds(Constants.delayToShowList))
            
            currentPage = Constants.initPage
            maxUserCount = try await userDataSource.getUserCount()
            
            let users = try await userDataSource.getUsers(
                limit: Constants.pageLimit,
                offset: currentPage * Constants.pageLimit
            )
            
            uiState.users = users
            uiState.hasMoreUsers = users.count < maxUserCount
            uiState.isLoading = false
        }
    }
    
    func loadMoreUsers() {
        let hasMoreUsers = uiState.hasMoreUsers
        let isLoadingMoreUsers = uiState.isLoadingMoreUsers
        
        if isLoadingMoreUsers || !hasMoreUsers {
            return
        }
        
        Task {
            uiState.isLoadingMoreUsers = true
            
            // Artificial delay to show that app is loading the next list
            try await Task.sleep(for: .milliseconds(Constants.delayToShowList))
            
            currentPage = currentPage + 1
            let newUsers = try await userDataSource.getUsers(
                limit: Constants.pageLimit,
                offset: currentPage * Constants.pageLimit
            )
            
            uiState.users += newUsers
            uiState.hasMoreUsers = uiState.users.count < maxUserCount
            uiState.isLoadingMoreUsers = false
        }
    }
    
}
