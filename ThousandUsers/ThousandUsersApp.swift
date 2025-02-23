//
//  ThousandUsersApp.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import SwiftUI

@main
struct ThousandUsersApp: App {
    
    var body: some Scene {
        WindowGroup {
            UserListView(
                viewModel: UserListViewModel(
                    dataSource: UserRepository(context: PersistenceController.shared.container.viewContext)
                )
            )
        }
    }
    
}
