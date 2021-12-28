//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by Stanislav Testov on 28.10.2021.
//

import UIKit
import MessageUI
import SafariServices


class EmailSenderSokrat {
    
    
    private var infoComplete = false
    
    let user = User(name: "Stanislav", contactDetails: "te100ff@inbox.ru", skills: ["C", "Delphi", "Basic"])
    
    
    
    private let controller: UIViewController
    private let internship: Internship?
    
    
    
    private lazy var messageBody: String = {
        guard let internship = internship else { return "Хочу пройти практику" }
        
        let message = """
        Хочу пройти практику
        \(internship.title) у "\(internship.projectName)"
        \(user.name) \(user.contactDetails)
        """
        return message
    }()
    
    private lazy var messageSubject: String = {
        guard let internship = internship else { return "Хочу пройти практику" }
        
        let subject = "\(user.name) \(user.contactDetails) \(internship.projectName) \(internship.title)"
        
        return subject
    }()
    
    
    private let alertController: UIAlertController = {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view?.layer.cornerRadius = 20
        alert.overrideUserInterfaceStyle = .light
        
        return alert
        
    }()
    
   
    
    init(controller: UIViewController, internship: Internship?) {
        self.controller = controller
        self.internship = internship
        //NotificationCenter.default.addObserver(self, selector: #selector(pasteboardChanged), name: UIPasteboard.changedNotification, object: nil)
        //UIPasteboard.general.string = "hr@sokratapp.ru"
        
        
    }
    
    func pasteboardChanged() {
        let alert = UIAlertController(
            title: "Адрес hr@sokratapp.ru скопирован",
            message: "Вставьте в строку получателя в вашем приложении почты",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.showActivityVC(message: self.messageBody, subject: self.messageSubject)
        }
        alert.addAction(action)
        
        controller.present(alert, animated: true) {
            UIPasteboard.general.string = "hr@sokratapp.ru"
        }
        
    }
    
    func presentAlert() {
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func emailSendingAlert() {
                
        if user.name.isEmpty || user.contactDetails.isEmpty || user.skills.isEmpty {
            infoComplete = false
            addFailedButtons()
        } else {
            infoComplete = true
            sendingEmail()
        }
        
        NSLayoutConstraint.activate([
            alertController.view.heightAnchor.constraint(equalToConstant: controller.view.frame.height / 4),
            alertController.view.widthAnchor.constraint(equalToConstant: controller.view.frame.width)
        ])
        
        addTitleLabel(emailSend: infoComplete)
        addMessageLabel(emailSend: infoComplete, user: user)
        
        presentAlert()
    }
    
    private func addTitleLabel(emailSend: Bool) {
        let successTitleLabel = UILabel()
        alertController.view.addSubview(successTitleLabel)
        successTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        successTitleLabel.text = emailSend ? "Заявка отправлена!" : "Заявка не отправлена!"
        successTitleLabel.textColor = emailSend ? .systemBlue : .red
        
        NSLayoutConstraint.activate([
            successTitleLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            successTitleLabel.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 24)
        ])
        
    }
    
    private func addMessageLabel(emailSend: Bool, user: User) {
        
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
        
        NSLayoutConstraint.activate([
            successMessageLabel.widthAnchor.constraint(equalToConstant: alertController.view.frame.width * 0.8 ),
            successMessageLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor)
        ])
        
        switch emailSend {
        case true:
            successMessageLabel.centerYAnchor.constraint(equalTo: alertController.view.centerYAnchor, constant: -8).isActive = true
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
                successMessageLabel.centerYAnchor.constraint(equalTo: alertController.view.centerYAnchor, constant: -24),
                emptyDataLabel.widthAnchor.constraint(equalToConstant: alertController.view.frame.width * 0.90 ),
                emptyDataLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
                emptyDataLabel.topAnchor.constraint(equalTo: successMessageLabel.bottomAnchor, constant: 8)
                
            ])
            
        }
        
    }
    
    func addSuccessButton() {
        let okButton = UIButton()
        let cancelAction = UIAction { _ in
            self.controller.dismiss(animated: true, completion: nil)
        }
        
        alertController.view.addSubview(okButton)
        
        
        okButton.backgroundColor = #colorLiteral(red: 0, green: 0.6549019608, blue: 0.8117647059, alpha: 1)
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
        let profileButton = UIButton(type: .system)
        let cancelAction = UIAction { _ in
            self.controller.dismiss(animated: true, completion: nil)
        }
        let toProfileAction = UIAction { _ in
            
//            guard let tabBar = self.controller.tabBarController else { return }
//
//            if let destinationIndex = tabBar.viewControllers?.firstIndex(where: {
//                let navController = $0 as? UINavigationController
//                return navController?.viewControllers.first is UserViewController
//            }) {
//                tabBar.selectedIndex = destinationIndex
//            }
//
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
        profileButton.backgroundColor = #colorLiteral(red: 0, green: 0.6549019608, blue: 0.8117647059, alpha: 1)
        profileButton.layer.cornerRadius = 10
        profileButton.addAction(cancelAction, for: .touchUpInside)
        profileButton.addAction(toProfileAction, for: .touchUpInside)
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
    
    private func sendingEmail() {
        
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.mailComposeDelegate = controller as? MFMailComposeViewControllerDelegate
            vc.setToRecipients(["te100ff@inbox.ru"])
            vc.setSubject(messageSubject)
            vc.setCcRecipients([])
            vc.setMessageBody(messageBody, isHTML: false)
            controller.present(vc, animated: true, completion: nil)
        } else {
            self.failedEmailSending()
        }
    }
    
    func failedEmailSending() {
       
        
//        UIPasteboard.general.string = "te100ff@inbox.ru"
        
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Отправка не удалась. Попробуйте ещё раз или воспользуйтесь своим приложением для отправки почты через \"Поделиться\"",
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        let repeatSending = UIAlertAction(title: "Ещё раз", style: .default) { _ in
            self.emailSendingAlert()
        }
        let share = UIAlertAction(title: "Поделиться", style: .default) { _ in
//            UIPasteboard.general.string = "hr@sokratapp.ru"
            self.pasteboardChanged()
            
//            self.showActivityVC(message: self.messageBody, subject: self.messageSubject)
        }
        
        alert.addAction(repeatSending)
        alert.addAction(share)
        alert.addAction(cancel)
        
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    private func showActivityVC(message: String, subject: String) {
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        vc.excludedActivityTypes = [
            .message,
            .addToReadingList,
            .airDrop,
            .assignToContact,
            .markupAsPDF,
            .openInIBooks,
            .postToFacebook,
            .postToFlickr,
            .postToTencentWeibo,
            .postToTwitter,
            .postToVimeo,
            .postToWeibo,
            .print,
            .saveToCameraRoll
        ]
        vc.setValue(subject, forKey: "Subject")
        controller.present(vc, animated: true)
//        UIPasteboard.general.string = "hr@sokratapp.ru"
       
    }
    
    deinit {
        print("alert deinit")
    }
 
    
}
