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
        label.textColor = Color.black.value
        // Enable Autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: NameLabel - TextField
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: cancelButtonTitle, style: .plain, target: self, action: #selector(handleCancelButton))
        
        view.backgroundColor = Color.darkBlue.value
        
        setupUI()
               
    }
    
    private func setupUI() {
        
        // Setup background lightblue background with Autolayout enabled
        let lightBlueBackgroundView = UIView()
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.backgroundColor = Color.lightblue.value
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Add nameLabel
        view.addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Add nameLabel text
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        
    }
    
    // MARK: Cancel Button Action
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
}

