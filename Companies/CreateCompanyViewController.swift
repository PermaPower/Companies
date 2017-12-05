//
//  CreateCompanyController.swift
//  Companies
//
//  Created by David on 8/11/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

// **** Now up to https://www.letsbuildthatapp.com/course_video?id=1992 @ x 8:38 seconds

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
            
            guard let founded = companyNameForRowSelected?.founded else {return}
            datePicker.date = founded
        }
    }
    
    // Instantiate a link between controllers
    var delegate: CreateCompanyViewControllerCustomDelegate?
    
    // Lightblue background color
    private let lightBlueBackgroundView: UIView = {
        let lbg = UIView()
        lbg.backgroundColor = Color.lightblue.value
        lbg.translatesAutoresizingMaskIntoConstraints = false
        return lbg
    }()
    
    // Company Image
    private lazy var companyImageView: UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Turn image into an interractive button (need lazy var)
        imageView.isUserInteractionEnabled = true
        // Add guester recognizer
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        
        return imageView
    }()
    
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
    
    // DatePicker
    private let datePicker: UIDatePicker = {
    let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = .date
        return dp
    }()
    
    
    // Founded name Label
    private let foundedNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Founded"
        label.textColor = Color.black.value
        // Enable Autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        // Setup background lightblue background with Autolayout enabled (Currently set with a 350 height)
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        // Add companyImageView
        view.addSubview(companyImageView)
        companyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // Add nameLabel
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Add nameLabel text
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        // Add founded nameLabel
        view.addSubview(foundedNameLabel)
        foundedNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        foundedNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        foundedNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        foundedNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Add datePicker
        view.addSubview(datePicker)
        datePicker.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    // Update header just before viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ternary Syntax
        navigationItem.title = companyNameForRowSelected == nil ? "Create Company" : "Edit Company"
        
    }
    
    // HandleSelectPhoto
    @objc private func handleSelectPhoto() {
        print ("Trying to select photo...")
        
        let imagePickerController = UIImagePickerController()
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // Cancel Button Action
    @objc private func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // Save Button Action
    @objc private func handleSaveButton() {
        
        if companyNameForRowSelected == nil {
            createCompany()
        } else
        {
            saveCompanyEditedChanges()
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
        company.setValue(datePicker.date, forKey: "founded")
        
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
    private func saveCompanyEditedChanges() {
        
        // Core Data
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        // Update variable with edited textfield
        companyNameForRowSelected?.name = nameTextField.text
        
        // Update founded date
        companyNameForRowSelected?.founded = datePicker.date
        
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
