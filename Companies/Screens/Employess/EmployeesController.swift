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
    }

    var company: Company?
    
    let cellID = "CellID"
    
    var employees = [Employee]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set navigation title
        navigationItem.title = company?.name
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        // Fetch Employees
        fetchEmployees()
        
        // Refresh dataview
        tableView.reloadData()
        
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
        
        shortNameEmployees = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count {
                return count < 6
            }
            return false
        })
        
        longNameEmployees = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count {
                return count > 6
            }
            return false
        })
        
        // Now load arrays into allEmployee array after filtering has been applied
        allEmployess = [
            shortNameEmployees,
            longNameEmployees
        ]

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Using custom IndentedLabel
        let label = IndentedLabel()
        label.backgroundColor = Color.lightblue.value
        label.textColor = Color.darkBlue.value
        label.font = UIFont.boldSystemFont(ofSize: 16)
        if section == 0 {
            label.text = "Short names"
        } else
        {
            label.text = "Long names"
        }
        return label
    }
    
    var shortNameEmployees = [Employee]()
    var longNameEmployees = [Employee]()
    
    // An array of arrays (sections)
    var allEmployess = [[Employee]]()
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployess[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployess.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let employee = allEmployess[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = employee.name

        // If birthday exists, then update textLabel
        if let birthday = employee.employeeInformation?.birthday {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM, yyyy"
            
            cell.textLabel?.text = "\(employee.name ?? "")  -  \(dateFormatter.string(from: birthday))"
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
    
    // Create a UILabel sublass for custom text drawing (spacing for section header)
    class IndentedLabel: UILabel {
        override func drawText(in rect: CGRect) {
            
            let insets = UIEdgeInsetsMake(0, 16, 0, 0)
            let customRect = UIEdgeInsetsInsetRect(rect, insets)
            super.drawText(in: customRect)
            
        }
    }
}
