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
                // Improvement: Put this DI in a dedicated class and call from AppDelegate if possible
                // For now, this works. My intention is to inject the dependencies from the top
                // AND handle it in one place
                viewModel: UserListViewModel(
                    dataSource: UserRepository(context: PersistenceController.shared.container.viewContext)
                )
            )
        }
    }
    
}
