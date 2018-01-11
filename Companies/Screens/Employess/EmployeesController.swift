//
//  EmployeesController.swift
//  Companies
//
//  Created by David on 7/12/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController {
    
    var company: Company?
    
    let cellID = "CellID"
    
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
    
    let employeeTypes = [
        EmployeeType.Executive.rawValue,
        EmployeeType.SeniorManagement.rawValue,
        EmployeeType.Staff.rawValue,
        EmployeeType.Intern.rawValue
    ]
    
    // Function to fetch employees
    private func fetchEmployees() {
        
        // Fetch all employess filtered by company name
        // As .allObjects gives us 'Anytype' - NSSet > Array
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        
        // Reset array first
        allEmployees = []
        
        employeeTypes.forEach { (employeeType) in
            
            allEmployees.append(
                companyEmployees.filter { $0.type == employeeType }
            )
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Using custom IndentedLabel
        let label = IndentedLabel()
        label.backgroundColor = Color.lightblue.value
        label.textColor = Color.darkBlue.value
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = employeeTypes[section]
        return label
    }
    
    // An array of arrays (sections)
    var allEmployees = [[Employee]]()
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let employee = allEmployees[indexPath.section][indexPath.row]
        
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

extension EmployeesController: CreateEmployeeControllerDelegate {

    // Called with we dismiss employee creation
    func didAddEmployee(employee: Employee) {
    
        guard let section = employeeTypes.index(of: employee.type!) else {return}
    
        // Looks at array count (entered as the next row for new entry)
        let row = allEmployees[section].count
        
        let insertionIndexPath = IndexPath(row: row, section: section)
        
        allEmployees[section].append(employee)
        
        tableView.insertRows(at: [insertionIndexPath], with: .middle)
        
    }
}
