//
//  UserListView.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import SwiftUI
import Combine

struct UserListView: View {
    
    @StateObject 
    private var viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.uiState.isLoading {
                    LoadingView()
                } else {
                    SearchField(
                        searchText: $viewModel.uiState.searchQuery,
                        hint: "Search user(s) by name...",
                        clear: {
                            viewModel.onSearchQueryChange(query: "")
                        },
                        onQueryChange: { query in
                            viewModel.onSearchQueryChange(query: query)
                        }
                    )
                    List {
                        ForEach(viewModel.uiState.users) { user in
                            UserListItemView(user: user)
                        }
                        
                        if viewModel.uiState.hasMoreUsers {
                            ZStack {
                                Color.clear
                                    .frame(height: 50)
                                    .onAppear {
                                        viewModel.loadMoreUsers()
                                    }
                                if viewModel.uiState.isLoadingMoreUsers {
                                    LoadingView()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
