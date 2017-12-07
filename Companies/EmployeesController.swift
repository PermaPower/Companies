//
//  EmployeesController.swift
//  Companies
//
//  Created by David on 7/12/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
    
    var company: Company?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set navigation title
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Format tableview background color
        tableView.backgroundColor = Color.darkBlue.value
        
        // Add bar button
        setupPlusButtonInNavBar(selector: #selector(handleAddButton))
 
    }

    // Handle Add Button action
    @objc private func handleAddButton() {
        
        let createEmployeeController = CreateEmployeeController()
        let navController = UINavigationController(rootViewController: createEmployeeController)
        
        present(navController, animated: true, completion: nil)
        
    }
}
