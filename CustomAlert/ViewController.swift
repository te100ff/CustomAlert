//
//  ViewController.swift
//  CustomAlert
//
//  Created by Stanislav Testov on 23.10.2021.
//

import UIKit
import MessageUI
import SafariServices

class ViewController: UIViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        showPickerController()
    }
    

    @IBAction func classButtonPressed(_ sender: UIButton) {
        let alert = EmailSender(viewController: self)
//        alert.showEmailAlert()
        alert.emailSendingAlert(emailsend: true)
    }
    
    
    func showPickerController() {
        let alertController = UIAlertController(title: "Translation Language", message: nil, preferredStyle: .actionSheet)
        let customView = UIView()
        let okButton = UIButton()
        
        alertController.view.addSubview(customView)
        alertController.view.addSubview(okButton)
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 16).isActive = true
        okButton.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -10).isActive = true
        okButton.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 10).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        okButton.backgroundColor = .blue
        okButton.layer.cornerRadius = 15
        okButton.setTitle("Хорошо", for: .normal)
        okButton.addTarget(self, action: #selector(tryToDismiss), for: .touchUpInside)
        
        
        
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 45).isActive = true
        customView.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -10).isActive = true
        customView.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 10).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        customView.backgroundColor = .green
        
        
        //        let selectAction = UIAlertAction(title: "Select", style: .default) { (action) in
        //            print("selection")
        //        }
        //
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        //        alertController.addAction(selectAction)
        //        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tryToDismiss() {
        
        dismiss(animated: true, completion: nil)
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.delegate = self
            vc.setToRecipients(["te100ff@inbox.ru"])
            vc.setSubject("Send E mail")
            vc.setCcRecipients(["te100ff@inbox.ru"])
            vc.setMessageBody("Hello!", isHTML: true)
            present(vc, animated: true, completion: nil)
        } else {
            guard let url = URL(string: "https://www.google.com") else {
                return
            }
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
        
        func mailComposeController(controller: MFMailComposeViewController, didFinishWith: MFMailComposeResult, error: Error?) {
            
            
            controller.dismiss(animated: true, completion: nil)
        }
    }
}
