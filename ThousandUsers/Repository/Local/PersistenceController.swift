//
//  PersistenceController.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/24/25.
//

import Foundation
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private let modelName = "thousandusers"
    private let urlString = "/dev/null"
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: modelName)
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: urlString)
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
}
