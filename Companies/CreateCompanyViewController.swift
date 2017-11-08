//
//  CreateCompanyController.swift
//  Companies
//
//  Created by David on 8/11/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit

private var navTitle = "Create Company"

class CreateCompanyViewController: UIViewController {
    
    override func viewDidLoad() {
        
        navigationItem.title = navTitle
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelButton))
        
        view.backgroundColor = .yellow
               
    }
    
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
}

