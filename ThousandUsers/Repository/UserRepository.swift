//
//  UserRepository.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation
import CoreData
import Combine

protocol UserDataSource {
    func populateDatabaseIfNeeded() async
    func getUsers(limit: Int, offset: Int) async throws -> [User]
    func getUserCount() async throws -> Int
}

class UserRepository: UserDataSource {
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func populateDatabaseIfNeeded() async {
        do {
            if (try await getUserCount() > 0) {
                print("Database populated!")
                return
            }
            
            let usersFromJson = try await MockDataProvider.loadUsersfromJSON()
            
            context.performAndWait {
                print("Saving \(usersFromJson.count) users from json mock data...")
                
                for user in usersFromJson {
                    let userEntity = UserEntity(context: self.context)
                    userEntity.id = Int32(user.id)
                    userEntity.firstName = user.firstName
                    userEntity.lastName = user.lastName
                    userEntity.email = user.email
                    userEntity.gender = user.gender
                    userEntity.status = user.status
                }
                
                do {
                    try context.save()
                    print("Database populated!")
                } catch {
                    print("Error saving context: \(error)")
                }
            }
        } catch {
            print("Error saving user: \(error)")
        }
    }
    
    func getUsers(limit: Int, offset: Int) async throws -> [User] {
        try await withCheckedThrowingContinuation { continuation in
            context.performAndWait {
                let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
                fetchRequest.fetchLimit = limit
                fetchRequest.fetchOffset = offset

                fetchRequest.sortDescriptors = [
                    NSSortDescriptor(keyPath: \UserEntity.id, ascending: true)
                ]
                
                do {
                    let entities = try context.fetch(fetchRequest)

                    let users = entities.map { entity in
                        User(
                            id: entity.id,
                            firstName: entity.firstName ?? "",
                            lastName: entity.lastName ?? "",
                            email: entity.email ?? "",
                            gender: entity.gender ?? "",
                            status: entity.status
                        )
                    }
                    continuation.resume(returning: users)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getUserCount() async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            context.performAndWait {
                let fetchRequest = UserEntity.fetchRequest()
                fetchRequest.resultType = .countResultType
                
                do {
                    let count = try context.count(for: fetchRequest)
                    continuation.resume(returning: count)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
}
