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
            List {
                ForEach(viewModel.uiState.users) { user in
                    UserListItemView(user: user)
                        .onAppear {
                            viewModel.loadMoreUsers()
                        }
                }
            }
        }
    }
}
