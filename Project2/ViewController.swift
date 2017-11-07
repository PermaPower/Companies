//
//  ViewController.swift
//  Project2
//
//  Created by David on 24/10/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var navTitle = "Companies"
    let cellID = "CellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationStyle()
        setupTableViewCells()
    }

    func setupTableViewCells() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func setupNavigationStyle() {
       
        tableView.backgroundColor = Color.background.value
        tableView.separatorStyle = .none
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Color.red.value
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddCompany))
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: Color.white.value]
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = navTitle
        } else {
            // Fallback on earlier versions
            navigationItem.title = navTitle
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.backgroundColor = Color.teal.value
        return cell
    }
    
    // Change the navigationItem.title color to white for all non iOS 11
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = Color.white.value
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Color.white.value]
    }
    
    @objc func handleAddCompany(){
        print("Adding company")
    }
}
