//
//  CompaniesViewController.swift
//  Project2
//
//  Created by David on 24/10/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit
import CoreData

class CompaniesViewController: UITableViewController  {
    
    private let navTitle = "Companies"
    private let cellID = "CellID"
    
    // Empty Array
    private var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanies()
        
        setupTableView()
    }

    private func fetchCompanies() {
        // Attempt to read Core Data Fetch somehow...
        // Initialization of our Core Data stack
        
        // Singleton
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            // Load array with Companies in Core Data
            self.companies = companies
            
            // Reload the tableView with array
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch companeis:", fetchErr)
        }
    }
    
    private func setupTableView() {
        
        navigationItem.title = navTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddCompany))
        
        tableView.backgroundColor = Color.darkBlue.value
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    // MARK: Sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    // MARK: Header Section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Color.lightblue.value
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // MARK: CellForRow
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.backgroundColor = Color.teal.value
        cell.textLabel?.textColor = Color.white.value
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        
        return cell
    }
    
    // Add edit and delete actions to tableView rows. Action is handled by handlerFunction
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteHandlerFunction)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        
        return [editAction, deleteAction]
    }
    
    // Private function to handle delete action handler
    private func deleteHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath){
        
        //let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let company = self.companies[indexPath.row]
            print ("Attempting to delete company: ", company.name ?? "")
            
            // Remove the company from the tableView
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Delete the company from CoreData
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to delte company:", saveErr)
            }
        //}
    }
    
    // Private function to handle edit action handler
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        print ("Editing company. (SEP)..")
        
        return
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
       
        let createCompanyController = CreateCompanyViewController()
        
        let navController = CustomWhiteNavigationController(rootViewController: createCompanyController)
        
        createCompanyController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
}

// MARK: CreateCompanyViewControllerCustomDelegate
extension CompaniesViewController: CreateCompanyViewControllerCustomDelegate {
    
    // Only called when delege is called
    func didAddCompany(company: Company) {
        
        // Modify array
        companies.append(company)
        
        // Insert new index path into tableView
        let newIndexPath = IndexPath(row: companies.count-1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
}
