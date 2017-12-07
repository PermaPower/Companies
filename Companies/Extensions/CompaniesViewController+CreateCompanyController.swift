//
//  CompaniesViewController+CreateCompany.swift
//  Companies
//
//  Created by David on 6/12/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit

// MARK: CreateCompanyViewControllerCustomDelegate
extension CompaniesController: CreateCompanyControllerCustomDelegate {
    
    // Only called when delege is called
    func didAddCompany(company: Company) {
        
        // Modify array
        companies.append(company)
        
        // Insert new index path into tableView
        let newIndexPath = IndexPath(row: companies.count-1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    // Update tableview after edit
    func didEditCompany(company: Company) {
        
        let row = companies.index(of: company)
        
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
        
    }
}
