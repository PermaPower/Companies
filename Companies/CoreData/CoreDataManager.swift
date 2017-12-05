//
//  CoreDataManager.swift
//  Companies
//
//  Created by David on 1/12/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    // Singleton - Instance of the class when required
    // Will live for ever as long as your application is still alive, it's properities will too
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let containter = NSPersistentContainer(name: "CoreDataModel")
        containter.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        })
        
        return containter
    }()
}
