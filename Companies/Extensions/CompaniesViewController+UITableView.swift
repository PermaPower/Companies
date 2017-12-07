//
//  CompaniesViewController+UITableViewDelegate.swift
//  Companies
//
//  Created by David on 6/12/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

// UITableViewDelegate functions

import UIKit

extension CompaniesController {
    
    // MARK: Sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    // MARK: Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Color.lightblue.value
        return view
    }
    
    // Adjust height of header section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // MARK: CellForRow
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CompanyCell
        
        // As cell is now a custom cell, you need to update the property of that custom cell
        let company = companies[indexPath.row]
        cell.company = company
        
        return cell
    }
    
    // Adjust height of each row
    internal override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // Add edit and delete actions to tableView rows. Action is handled by handlerFunction
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteHandlerFunction)
        deleteAction.backgroundColor = Color.red.value
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        editAction.backgroundColor = Color.darkBlue.value
        
        return [editAction, deleteAction]
    }
    
    // Private function to handle Delete action handler
    private func deleteHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath){
        
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
    }
    
    // Private function to handle Edit action handler
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        
        // Model view
        let editCompanyController = CreateCompanyController()
        editCompanyController.delegate = self
        editCompanyController.companyNameForRowSelected = companies[indexPath.row]
        let navController = CustomWhiteNavigationController(rootViewController: editCompanyController)
        present(navController, animated: true, completion: nil)
        
    }
}
