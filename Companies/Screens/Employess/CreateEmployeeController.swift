//
//  CreateEmployeeController.swift
//  Companies
//
//  Created by David on 7/12/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    // Create variable to store company name
    var company: Company?

    // Delegate will call Delegate function
    var delegate: CreateEmployeeControllerDelegate?
    
    // NameLabel
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = Color.black.value
        // Enable Autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // NameLabel - TextField
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Employee"
        
        setupCancelButton()
        setupSaveButton(selector: #selector(handleSaveButton))
        
        view.backgroundColor = Color.darkBlue.value
        
        setupLightBlueBackgroundView(height: 50)
        
        setupUI()
        }
    
    private func setupUI() {
        
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
    
    @objc private func handleSaveButton() {
        print ("Saving employee")
        
        // Create employee using the singlton function
        
        guard let employeeName = nameTextField.text else { return }
        guard let company = self.company else { return }
        
        let tuple = CoreDataManager.shared.createEmployee(employeeName: employeeName, company: company)
        
        if let error = tuple.1 {
            // This is where you present an error model of some kind
            print (error)
        } else {
            // Creation OK
            dismiss(animated: true, completion: {
            
                self.delegate?.didAddEmployee(employee: tuple.0!)
                
            })
        }
        
       
    }
}
