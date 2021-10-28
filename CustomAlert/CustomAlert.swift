//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by Stanislav Testov on 28.10.2021.
//

import UIKit

class EmailSender {
//
//    var viewController: UIViewController
//
//    init(viewController: UIViewController) {
//        self.viewController = viewController
//    }
    
    init() {}
    
    private let alertController: UIAlertController = {
        let alert = UIAlertController(title: "nil", message: nil, preferredStyle: .actionSheet)
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return alert
        
    }()
    
    
    func showEmailAlert(on viewController: UIViewController) {
        
        
        
        let okButton = UIButton()
        alertController.view.addSubview(okButton)
        
        alertController.view.heightAnchor.constraint(equalToConstant: viewController.view.frame.height / 4).isActive  = true
        
        okButton.backgroundColor = .tintColor
        okButton.setTitle("Check", for: .normal)
        okButton.titleLabel?.textColor = .systemRed
        okButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            okButton.widthAnchor.constraint(equalToConstant: alertController.view.frame.width * 0.8),
            okButton.heightAnchor.constraint(equalToConstant: alertController.view.frame.height * 0.4),
            okButton.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor , constant: -16),
            okButton.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor)
        ])
        
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
}
