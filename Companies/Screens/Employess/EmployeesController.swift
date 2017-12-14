//
//  EmployeesController.swift
//  Companies
//
//  Created by David on 7/12/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    
    // Applies custom delegate function
    func didAddEmployee(employee: Employee) {
        // Appends employee recieved to employees array
        employees.append(employee)
        tableView.reloadData()
    }

    var company: Company?
    
    let cellID = "CellID"
    
    var employees = [Employee]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set navigation title
        navigationItem.title = company?.name
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Format tableview background color
        tableView.backgroundColor = Color.darkBlue.value
        
        // Add bar button
        setupPlusButtonInNavBar(selector: #selector(handleAddButton))
        
        // Fetch Employees
        fetchEmployees()
 
    }
    
    // Function to fetch employees
    private func fetchEmployees() {
        
        // Fetch all employess filtered by company name
        // As .allObjects gives us 'Anytype' - NSSet > Array
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        
        self.employees = companyEmployees
        
        
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//
//        let request = NSFetchRequest<Employee>(entityName: "Employee")
//
//        do {
//            let employees = try context.fetch(request)
//
//            self.employees = employees
//            //employess.forEach{print("Employee name:", $0.name ?? "")}
//
//        } catch let err {
//            print ("Failed to fetch employees: " , err)
//        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let employee = employees[indexPath.row]
        
        cell.textLabel?.text = employee.name
        
        // If TaxID exists, then update textLabel
        if let taxID = employee.employeeInformation?.taxID {
            cell.textLabel?.text = "\(employee.name ?? "")    \(taxID)"
        }
        
        cell.backgroundColor = Color.teal.value
        cell.textLabel?.textColor = Color.white.value
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        return cell
    }
    

    // Handle Add Button action
    @objc private func handleAddButton() {
        
        let createEmployeeController = CreateEmployeeController()
        
        createEmployeeController.delegate = self
        createEmployeeController.company = self.company
        
        let navController = UINavigationController(rootViewController: createEmployeeController)
        
        present(navController, animated: true, completion: nil)
        
    }
}
