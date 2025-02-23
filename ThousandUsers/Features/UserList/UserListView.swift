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
    private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.uiState.users) { user in
                    UserListItemView(user: user)
                }
            }
        }
    }
}

#Preview {
    UserListView()
}
