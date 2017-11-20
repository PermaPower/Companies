//
//  CreateCompanyController.swift
//  Companies
//
//  Created by David on 8/11/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit

private let navTitle = "Create Company"
private let cancelButtonTitle = "Cancel"

class CreateCompanyViewController: UIViewController {
    
    // MARK: NameLabel
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = Color.white.value
        label.backgroundColor = Color.teal.value
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: cancelButtonTitle, style: .plain, target: self, action: #selector(handleCancelButton))
        
        view.backgroundColor = Color.darkBlue.value
        
        setupUI()
               
    }
    
    private func setupUI() {
        
        view.addSubview(nameLabel)
        
        nameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
    }
    
    // MARK: Cancel Button Action
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
}

