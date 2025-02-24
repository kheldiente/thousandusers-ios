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
    private var searchQuery = ""
    private var searchTask: Task<Void, Never>?
    
    init(dataSource: UserDataSource) {
        userDataSource = dataSource
        populateDbIfNeeded()
        
        Task {
            uiState.isLoading = true
            try await Task.sleep(for: .milliseconds(Constants.delayToShowList))
            
            loadInitData()
            
            uiState.isLoading = false
        }
    }
    
    private func populateDbIfNeeded() {
        Task {
            await userDataSource.populateDatabaseIfNeeded()
        }
    }
    
    func loadInitData() {
        Task {
            currentPage = Constants.initPage
            maxUserCount = try await userDataSource.getUserCount(keyword: searchQuery)
            
            let users = try await userDataSource.getUsers(
                keyword: searchQuery,
                limit: Constants.pageLimit,
                offset: currentPage * Constants.pageLimit
            )
            
            uiState.users = users
            uiState.hasMoreUsers = users.count < maxUserCount
        }
    }
    
    func onSearchQueryChange(query: String = "") {
        searchTask?.cancel()
        searchQuery = query
        
        searchTask = Task {
            uiState.searchQuery = query
            loadInitData()
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
                keyword: searchQuery,
                limit: Constants.pageLimit,
                offset: currentPage * Constants.pageLimit
            )
            
            uiState.users += newUsers
            uiState.hasMoreUsers = uiState.users.count < maxUserCount
            uiState.isLoadingMoreUsers = false
        }
    }
    
}
