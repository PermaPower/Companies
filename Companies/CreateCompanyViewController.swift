//
//  CreateCompanyController.swift
//  Companies
//
//  Created by David on 8/11/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

// **** Now up to https://www.letsbuildthatapp.com/course_video?id=1892 @ x 11:09 seconds

import UIKit
import CoreData

private let cancelButtonTitle = "Cancel"
private let saveButtonTitle = "Save"

// MARK: Custom Delegation
protocol CreateCompanyViewControllerCustomDelegate {
    
    // Function will run when custom delegate is called
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyViewController: UIViewController {
    
    // Add companyNameForRowSelected property to class (used in modal)
    var companyNameForRowSelected: Company? {
        didSet {
            nameTextField.text = companyNameForRowSelected?.name
        }
    }
    
    // Instantiate a link between controllers
    var delegate: CreateCompanyViewControllerCustomDelegate?
    
    // MARK: Lightblue background color
    private let lightBlueBackgroundView: UIView = {
        let lbg = UIView()
        lbg.backgroundColor = Color.lightblue.value
        lbg.translatesAutoresizingMaskIntoConstraints = false
        return lbg
    }()
    
    // MARK: NameLabel
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = Color.black.value
        // Enable Autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: NameLabel - TextField
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        
        // Setup navigation bar title and buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: cancelButtonTitle, style: .plain, target: self, action: #selector(handleCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: saveButtonTitle, style: .plain, target: self, action: #selector(handleSaveButton))
        
        // Setup background color for view
        view.backgroundColor = Color.darkBlue.value
        
        // Setup background lightblue background with Autolayout enabled
        view.addSubview(lightBlueBackgroundView)
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
    
    // Update header just before viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ternary Syntax
        navigationItem.title = companyNameForRowSelected == nil ? "Create Company" : "Edit Company"
        
    }
    
    // MARK: Cancel Button Action
    @objc private func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Save Button Action
    @objc private func handleSaveButton() {
        
        if companyNameForRowSelected == nil {
            createCompany()
        } else
        {
            saveCompanyChanges()
        }
    }
    
    // Save to coredata Company
    private func createCompany () {
        // Test to see if name is blank.  If it is then exit function before any data is saved to Coredata
        guard !(nameTextField.text?.isEmpty)! else {
            print ("No name to submit")
            return
        }
        
        // initialization of our Core Data stack
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        
        company.setValue(nameTextField.text, forKey: "name")
        
        // perform the save
        do {
            try context.save()
            
            // success
            dismiss(animated: true, completion: {
                self.delegate?.didAddCompany(company: company as! Company)
            })
            
        } catch let saveErr {
            print("Failed to save company:", saveErr)
        }
    }
    
    // Save company changes
    private func saveCompanyChanges() {
        
        // Coredata update
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        companyNameForRowSelected?.name = nameTextField.text
        
        do {
            try context.save()

            // Dimisss modal
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.companyNameForRowSelected!)
            })
            
        } catch let saveErr {
            print("Error when trying to save updates to CoreData: ", saveErr)
        }

    }

}
