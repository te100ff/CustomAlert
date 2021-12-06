//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by Stanislav Testov on 28.10.2021.
//

import UIKit
import MessageUI
import SafariServices


class EmailSenderTesting {
    
    //var emailSend = false

    var controller: UIViewController!
    
   
    
    init(viewController: UIViewController) {
        self.controller = viewController
    }
    
    init() {}
    
    private let alertController: UIAlertController = {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
       
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view?.layer.cornerRadius = 20
        alert.overrideUserInterfaceStyle = .light
        
        return alert
        
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        
        
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        //indicator.stopAnimating()
        
        return indicator
    }()
    
    
    
    func emailSendingAlert(emailsend: Bool) {
        
        NSLayoutConstraint.activate([
            alertController.view.heightAnchor.constraint(equalToConstant: controller.view.frame.height / 4),
            alertController.view.widthAnchor.constraint(equalToConstant: controller.view.frame.width)
        ])
        
        addTitleLabel(emailSend: emailsend)
        addMessageLabel(emailSend: emailsend)
        
        if emailsend {
            addSuccessButton()
            
        } else {
            addFailedButtons()
            
        }
        
        controller.present(alertController, animated: true, completion: nil)
     }
    
    private func addTitleLabel(emailSend: Bool) {
        let successTitleLabel = UILabel()
        alertController.view.addSubview(successTitleLabel)
        successTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        successTitleLabel.text = emailSend ? "Заявка отправлена!" : "Заявка не отправлена!"
        successTitleLabel.textColor = emailSend ? .tintColor : .red
        
        NSLayoutConstraint.activate([
            successTitleLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            successTitleLabel.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 16)
        ])
        
    }
    
    private func addMessageLabel(emailSend: Bool) {
        
      
        
        var user = User()
        
        
        let successMessageLabel = UILabel()
        
        
        alertController.view.addSubview(successMessageLabel)
        
    
        let textValue = emailSend
        ? "Ваша заявка успешно отправлена! \nМы с вами свяжемся в ближайшее время!"
        : "Заполните недостающие данные в вашем профиле:"
        
        var emptyDataText: [String] = []
        
        if user.name.isEmpty { emptyDataText.append("ФИО")}
        if user.contactDetails.isEmpty { emptyDataText.append("E-mail")}
        if user.skills.isEmpty { emptyDataText.append("Навыки")}
        
        
        
        successMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        successMessageLabel.numberOfLines = 1
        successMessageLabel.textColor = .darkGray
        successMessageLabel.textAlignment = .center
        successMessageLabel.adjustsFontSizeToFitWidth = true
        successMessageLabel.text = textValue
        
        
        switch emailSend {
        case true:
            NSLayoutConstraint.activate([
                successMessageLabel.widthAnchor.constraint(equalToConstant: alertController.view.frame.width * 0.8 ),
                successMessageLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
                successMessageLabel.centerYAnchor.constraint(equalTo: alertController.view.centerYAnchor, constant: -8)
            ])
        case false:
            let emptyDataLabel = UILabel()
            alertController.view.addSubview(emptyDataLabel)
            
            emptyDataLabel.translatesAutoresizingMaskIntoConstraints = false
            emptyDataLabel.numberOfLines = 1
            emptyDataLabel.textColor = .darkGray
            emptyDataLabel.textAlignment = .center
            emptyDataLabel.adjustsFontSizeToFitWidth = true
            emptyDataLabel.text = emptyDataText.joined(separator: " / ")
            
            NSLayoutConstraint.activate([
                successMessageLabel.widthAnchor.constraint(equalToConstant: alertController.view.frame.width * 0.8 ),
                successMessageLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
                successMessageLabel.centerYAnchor.constraint(equalTo: alertController.view.centerYAnchor, constant: -24),
                emptyDataLabel.widthAnchor.constraint(equalToConstant: alertController.view.frame.width * 0.90 ),
                emptyDataLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
                emptyDataLabel.topAnchor.constraint(equalTo: successMessageLabel.bottomAnchor, constant: 8)
                
            ])
            
        }
        
        
        
    }
    
    private func addSuccessButton() {
        let okButton = UIButton()
        let cancelAction = UIAction { _ in
            self.controller.dismiss(animated: true, completion: nil)
         }
        
        alertController.view.addSubview(okButton)
        
        okButton.backgroundColor = .tintColor
        okButton.setTitle("Хорошо", for: .normal)
        okButton.titleLabel?.textColor = .systemRed
        okButton.layer.cornerRadius = 10
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.addAction(cancelAction, for: .touchUpInside)
            
        NSLayoutConstraint.activate([
            okButton.widthAnchor.constraint(equalToConstant: controller.view.frame.width * 0.9),
            okButton.heightAnchor.constraint(equalToConstant: controller.view.frame.height / 20),
            okButton.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor , constant: -16),
            okButton.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor)
        ])
        
    }
    
    private func addFailedButtons() {
        let cancelButton = UIButton()
        let profileButton = UIButton()
        let cancelAction = UIAction { _ in
            self.controller.dismiss(animated: true, completion: nil)
         }
        
        alertController.view.addSubview(cancelButton)
        alertController.view.addSubview(profileButton)
        
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.backgroundColor?.withAlphaComponent(0)
        cancelButton.layer.cornerRadius = 10
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addAction(cancelAction, for: .touchUpInside)
        
        
        profileButton.setTitle("В профиль", for: .normal)
        profileButton.setTitleColor(.white, for: .normal)
        profileButton.backgroundColor = .tintColor
        profileButton.layer.cornerRadius = 10
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.widthAnchor.constraint(equalToConstant: controller.view.frame.width * 0.4),
            profileButton.widthAnchor.constraint(equalToConstant: controller.view.frame.width * 0.4),
            cancelButton.heightAnchor.constraint(equalToConstant: controller.view.frame.height / 20),
            profileButton.heightAnchor.constraint(equalToConstant: controller.view.frame.height / 20),
            cancelButton.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor , constant: -16),
            profileButton.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor , constant: -16),
            cancelButton.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 16),
            profileButton.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -16)
        ])
            
    }
    
    @objc func sendingEmail() {
        
        controller.dismiss(animated: true, completion: nil)
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.mailComposeDelegate = controller as? MFMailComposeViewControllerDelegate
            vc.setToRecipients(["te100ff@inbox.ru"])
            vc.setSubject("Send E mail")
            vc.setCcRecipients(["te100ff@inbox.ru"])
            vc.setMessageBody("Hello!", isHTML: true)
            controller.present(vc, animated: true, completion: nil)
        } else {
            guard let url = URL(string: "https://www.google.com") else {
                return
            }
            let vc = SFSafariViewController(url: url)
            controller.present(vc, animated: true, completion: nil)
        }
        
        func mailComposeController(controller: MFMailComposeViewController, didFinishWith: MFMailComposeResult, error: Error?) {
            
            switch didFinishWith {
            case .cancelled:
                print("Email canceled")
            case .saved:
                print("Email saved")
            case .sent:
                print("Email SENT")
            case .failed:
                print("Email sending failed")
            @unknown default:
                fatalError()
            }
            
            controller.dismiss(animated: true, completion: nil)
        }
    }
   
 
    
}
