//
//  CreateCompanyController.swift
//  Companies
//
//  Created by David on 8/11/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit
import CoreData

private let saveButtonTitle = "Save"

// MARK: Custom Delegation
protocol CreateCompanyControllerCustomDelegate {
    
    // Function will run when custom delegate is called
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // Add companyNameForRowSelected property to class (used in modal)
    var companyNameForRowSelected: Company? {
        
        didSet {
            nameTextField.text = companyNameForRowSelected?.name
            
            // Set the image if CoreData has one
            if let imageData = companyNameForRowSelected?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
            
            // Setup cirular image style
            setupCircularImageSytle()
           
            guard let founded = companyNameForRowSelected?.founded else {return}
            datePicker.date = founded
        }
    }
    
    // Setup circluar style for images
    private func setupCircularImageSytle() {
        
        // Make image circular
        companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
        companyImageView.clipsToBounds = true
        companyImageView.layer.borderColor = Color.darkBlue.value.cgColor
        companyImageView.layer.borderWidth = 0.5
        
    }
    
    // Instantiate a link between controllers
    var delegate: CreateCompanyControllerCustomDelegate?
       
    // Company Image
    private lazy var companyImageView: UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
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
        setupCancelButton()
        setupSaveButton(selector: #selector(handleSaveButton))
        
        // Setup background color for view
        view.backgroundColor = Color.darkBlue.value
        
        // Setup background lightblue background with Autolayout enabled
        setupLightBlueBackgroundView(height: 350)
        
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
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // Animate imagePickerController dismiss function
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Selected image information
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            companyImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            companyImageView.image = originalImage
        }
        
        // Setup cirular image style
        setupCircularImageSytle()
        
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
        
        // Save image at 80% compression
        if let companyImage = companyImageView.image {
            let imageData = UIImageJPEGRepresentation(companyImage, 0.8)
            company.setValue(imageData, forKey: "imageData")
        }
        
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
        
        // Show Image
        if let companyImage = companyImageView.image {
            let imageData = UIImageJPEGRepresentation(companyImage, 0.8)
            companyNameForRowSelected?.imageData = imageData
        }
        
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
