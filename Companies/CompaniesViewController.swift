//
//  ViewController.swift
//  Project2
//
//  Created by David on 24/10/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit

class CompaniesViewController: UITableViewController {
    
    private var navTitle = "Companies"
    private let cellID = "CellID"
    
    let companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        navigationItem.title = navTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddCompany))
        
        tableView.backgroundColor = Color.background.value
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
    
    // Change the navigationItem.title color to white for all non iOS 11
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nav = self.navigationController?.navigationBar
        
        nav?.tintColor = Color.white.value
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Color.white.value]
        
    }
    
    @objc private func handleAddCompany(){
        print("Adding company")
        
        let createCompanyController = CreateCompanyViewController()
        //createCompanyController.view.backgroundColor = .green
        
        let navController = CustomWhiteNavigationController(rootViewController: createCompanyController)
        
        present(navController, animated: true, completion: nil)
    }
}
