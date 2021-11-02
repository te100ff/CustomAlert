//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by Stanislav Testov on 28.10.2021.
//

import UIKit


class EmailSender {
    
    //var emailSend = false

    var controller: UIViewController!
    

    init(viewController: UIViewController) {
        self.controller = viewController
    }
    
    init() {}
    
    private let alertController: UIAlertController = {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        //alert.view.heightAnchor.constraint(equalToConstant: ).isActive = true
        alert.view.clipsToBounds = true
        alert.view?.layer.cornerRadius = 20
        alert.view.backgroundColor = .white
        
        return alert
        
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        
        
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        //indicator.stopAnimating()
        
        return indicator
    }()
    
    //Ваша заявка успешно отправлена! Мы с вами свяжемся в ближайшее время!
    

    func alertSetup() {
        
        //let activityIndicator = UIActivityIndicatorView(style: .large)
        let okButton = UIButton()
        let successTitleLabel = UILabel()
        let successMesageLabel = UILabel()
        
        alertController.view.addSubview(okButton)
        alertController.view.addSubview(activityIndicator)
        alertController.view.addSubview(successTitleLabel)
        alertController.view.addSubview(successMesageLabel)
        
        successMesageLabel.translatesAutoresizingMaskIntoConstraints = false
        successMesageLabel.numberOfLines = 0
        successMesageLabel.textColor = .darkGray
        successMesageLabel.textAlignment = .center
        successMesageLabel.text = "Ваша заявка успешно отправлена! \nМы с вами свяжемся в ближайшее время!"
        
        successTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        successTitleLabel.text = "Заявка отправлена"
        successTitleLabel.textColor = .tintColor
        
        
       
        activityIndicator.center = CGPoint(
            x: alertController.view.frame.width / 2,
            y: alertController.view.frame.height / 8
        )
        
        //okButton.isHidden = true
        
        okButton.backgroundColor = .tintColor
        okButton.setTitle("Хорошо", for: .normal)
        okButton.titleLabel?.textColor = .systemRed
        okButton.layer.cornerRadius = 10
        okButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertController.view.heightAnchor.constraint(equalToConstant: controller.view.frame.height / 4),
            alertController.view.widthAnchor.constraint(equalToConstant: controller.view.frame.width),
            okButton.widthAnchor.constraint(equalToConstant: controller.view.frame.width * 0.9),
            okButton.heightAnchor.constraint(equalToConstant: controller.view.frame.height / 20),
            okButton.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor , constant: -16),
            okButton.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            successTitleLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            successTitleLabel.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 16),
            successMesageLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            successMesageLabel.topAnchor.constraint(equalTo: successTitleLabel.bottomAnchor, constant: 16)
        ])
        
        
        controller.present(alertController, animated: true, completion: nil)
        
    }
    
    func emailSendingAlert(emailsend: Bool) {
        
        NSLayoutConstraint.activate([
            alertController.view.heightAnchor.constraint(equalToConstant: controller.view.frame.height / 4),
            alertController.view.widthAnchor.constraint(equalToConstant: controller.view.frame.width)
        ])
        
        addTitleLabel(emailSend: emailsend)
        addMessageLabel(emailSend: emailsend)
        
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
        
        let successMesageLabel = UILabel()
        alertController.view.addSubview(successMesageLabel)
        
        successMesageLabel.translatesAutoresizingMaskIntoConstraints = false
        successMesageLabel.numberOfLines = 2
        successMesageLabel.textColor = .darkGray
        successMesageLabel.textAlignment = .center
        successMesageLabel.adjustsFontSizeToFitWidth = true
        
        let textValue = emailSend
        ? "Ваша заявка успешно отправлена! \nМы с вами свяжемся в ближайшее время!"
        : "Заполните недостающие данные в вашем профиле: ФИО Почта Навыки"
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 64
        style.alignment = .center
       
        
        
        
        successMesageLabel.attributedText = NSAttributedString(string: textValue, attributes: [.paragraphStyle : style])
        
        
        NSLayoutConstraint.activate([
            successMesageLabel.widthAnchor.constraint(equalToConstant: alertController.view.frame.width * 0.9),
            successMesageLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            successMesageLabel.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 45)
        ])
        
        
        
    }
}
