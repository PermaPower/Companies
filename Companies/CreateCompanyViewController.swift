//
//  CreateCompanyController.swift
//  Companies
//
//  Created by David on 8/11/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

// **** Now up to https://www.letsbuildthatapp.com/course_video?id=1862 @ x 7:35 seconds

import UIKit
import CoreData

private let navTitle = "Create Company"
private let cancelButtonTitle = "Cancel"
private let saveButtonTitle = "Save"

// MARK: Custom Delegation
protocol CreateCompanyViewControllerCustomDelegate {
    
    // Function will run when custom delegate is called
    func didAddCompany(company: Company)
}

class CreateCompanyViewController: UIViewController {
    
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
        navigationItem.title = navTitle
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
    
    // MARK: Cancel Button Action
    @objc private func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Save Button Action
    @objc private func handleSaveButton() {
        
        // Setup dismiss model popup view with animation.  It is in closure so that animation happens after window is closed
        dismiss(animated: true) {
            
            // Initialization of our Core Data stack
            
            let persistentContainer = NSPersistentContainer(name: "CoreDataModel")
            persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error {
                    fatalError("Loading of store failed: \(error)")
                }
            })
            
            let context = persistentContainer.viewContext
            
            let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
            
            company.setValue(self.nameTextField.text, forKey: "name")
            
            // Performce the Core Data save
            do {
                 try context.save()
            } catch let saveErr {
                print ("Failed to save company: ",saveErr)
            }
            
           
            
            
            // Read textfiled name (non-blank)
//            guard let name = self.nameTextField.text else {return}
//
//            let company = Company(name: name, founded: Date())
//
//            // Call delegate function
//            self.delegate?.didAddCompany(company: company)
        }
    }
}
