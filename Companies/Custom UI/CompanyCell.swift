//
//  CompanyCell.swift
//  Companies
//
//  Created by David on 6/12/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit


class CompanyCell: UITableViewCell {
    
    // Property
    var company: Company? {
        
        didSet {
            nameFoundedDateLabel.text = company?.name
            
            // Use image if it exists in CoreData
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
            
            if let name = company?.name, let founded = company?.founded {
                
                // Date formatter
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM YYYY"
                
                let foundedDateString = dateFormatter.string(from: founded)
                
                // Set English Locale
                // let locale = Locale(identifier: "EN")
                
                let dateString = "\(name) - Founded: \(foundedDateString)"
                nameFoundedDateLabel.text = dateString
            } else {
                nameFoundedDateLabel.text = company?.name
            }
            
        }
    }
    
    let companyImageView: UIImageView = {
        
        // Default Image
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = Color.darkBlue.value.cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    let nameFoundedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Color.white.value
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Color.teal.value

        // Add imageview
        addSubview(companyImageView)
        companyImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            companyImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        } else {
            // Fallback on earlier versions
            companyImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        }
        
        // Add name and founded date label
        addSubview(nameFoundedDateLabel)
        nameFoundedDateLabel.leftAnchor.constraint(equalTo: companyImageView.rightAnchor, constant: 10).isActive = true
        nameFoundedDateLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameFoundedDateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameFoundedDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
