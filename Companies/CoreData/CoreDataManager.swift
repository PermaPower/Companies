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
    
    // Function to return companies array
    func fetchCompanies() -> [Company] {
        
        // Attempt to read Core Data Fetch somehow...
        // Initialization of our Core Data stack
        
        // Singleton
        // let context = CoreDataManager.shared.persistentContainer.viewContext (Full reference not needed as part of current class)
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            // Return array
            return companies
            
        } catch let fetchErr {
            print("Failed to fetch companeis:", fetchErr)
            
            // Return empty array if error occured
            return []
        }
        
    }
    
    // Use optional Tuple to return values from function
    func createEmployee(employeeName: String) -> (Employee?, Error?) {
        
        let context=persistentContainer.viewContext
        
        // Create an employee
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        employee.setValue(employeeName, forKey: "name")
        
        do {
            try context.save()
            
            // Save OK
            return (employee, nil)
            
        } catch let err {
            print ("Error trying to sve employee: \(err)")
            
            // Save failed
            return (nil, err)
        }
        
    }
}
