//
//  CompaniesViewController.swift
//  Project2
//
//  Created by David on 24/10/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController  {
    
    let navTitle = "Companies"
    let cellID = "CellID"
    
    // Empty Array
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call function and load into variable
        // TableView will reload automatically as it is part of the viewDidLoad function (special)
        self.companies = CoreDataManager.shared.fetchCompanies()
        
        setupTableView()
    }

    private func setupTableView() {
        
        navigationItem.title = navTitle
        setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
        
        tableView.backgroundColor = Color.darkBlue.value
        tableView.separatorStyle = .none
        
        // Register custom UITableViewCell - CompanyCell
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellID)
    }

    // Change the navigationItem.title color to white for all non iOS 11
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nav = self.navigationController?.navigationBar
        
        nav?.tintColor = Color.white.value
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Color.white.value]
        
    }
    
    // Add Company Button Action
    @objc private func handleAddCompany(){
        
        let createCompanyController = CreateCompanyController()
        
        let navController = CustomWhiteNavigationController(rootViewController: createCompanyController)
        
        createCompanyController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }

}
