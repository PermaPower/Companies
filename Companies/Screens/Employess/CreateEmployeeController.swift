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
    
    // BirthdayLabel
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        label.textColor = Color.black.value
        // Enable Autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // NameLabel - TextField
    private let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "dd/MM/yyyy"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // EmployeeType - Segmented controller
    private let employeeTypeSegmentedControl: UISegmentedControl = {
        let types = [
            EmployeeType.Executive.rawValue,
            EmployeeType.SeniorManagement.rawValue,
            EmployeeType.Staff.rawValue,
            EmployeeType.Intern.rawValue
        ]
        let sc = UISegmentedControl(items: types)
        sc.selectedSegmentIndex = 0
        sc.tintColor = Color.darkBlue.value
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Employee"
        
        setupCancelButton()
        setupSaveButton(selector: #selector(handleSaveButton))
        
        view.backgroundColor = Color.darkBlue.value
        
        setupUI()
        }
    
    private func setupUI() {
        
        setupLightBlueBackgroundView(height: 150)
        
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
        
        // Add birthdayLabel
        view.addSubview(birthdayLabel)
        birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        birthdayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        birthdayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        birthdayLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Add nameLabel text
        view.addSubview(birthdayTextField)
        birthdayTextField.leftAnchor.constraint(equalTo: birthdayLabel.rightAnchor).isActive = true
        birthdayTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        birthdayTextField.bottomAnchor.constraint(equalTo: birthdayLabel.bottomAnchor).isActive = true
        birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.topAnchor).isActive = true
        
        // Add segmented control
        view.addSubview(employeeTypeSegmentedControl)
        employeeTypeSegmentedControl.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 0).isActive = true
        employeeTypeSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        employeeTypeSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        employeeTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
    }
    
    @objc private func handleSaveButton() {

        // Turn birthdayTextField.text into a date object
        guard let birthdayText = birthdayTextField.text else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        // Check to see if date entered can be formatted, if not, then Alert user and return
        guard let birthdayDate = dateFormatter.date(from: birthdayText)
            else {
                showError(title: "Bad date!", message: "Date entered is not valid.")
                return
        }
        
        guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else {return}
       
        // Create employee using the singlton function
        
        guard let employeeName = nameTextField.text else { return }
        guard let company = self.company else { return }
        
        // Perform validation check step here
        if birthdayText.isEmpty {
            showError(title: "Empty birthday!", message: "Please enter in a valid birth date.")
            return
        }
        
        let tuple = CoreDataManager.shared.createEmployee(employeeName: employeeName, employeeType: employeeType, birthday: birthdayDate, company: company)
        
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

    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}


