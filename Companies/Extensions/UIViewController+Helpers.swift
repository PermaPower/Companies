//
//  UIViewController+Helpers.swift
//  Companies
//
//  Created by David on 7/12/17.
//  Copyright © 2017 Permaculture Power. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Helper methods
    
    // Setup Plus button
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    // Setup Cancel button
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    // Setup Save button
    func setupSaveButton(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: selector)
    }
    
    // Setup Lightblue background
    func setupLightBlueBackgroundView(height: CGFloat) {

        // Lightblue background color
        let lightBlueBackgroundView: UIView = {
            let lbg = UIView()
            lbg.backgroundColor = Color.lightblue.value
            lbg.translatesAutoresizingMaskIntoConstraints = false
            return lbg
        }()
        
        // Setup background lightblue background with Autolayout enabled (Currently set with a 350 height)
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
}
