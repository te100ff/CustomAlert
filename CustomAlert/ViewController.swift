//
//  ViewController.swift
//  CustomAlert
//
//  Created by Stanislav Testov on 23.10.2021.
//

import UIKit
import MessageUI
import SafariServices

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    private let image = UIImage(systemName: "arrow.down.forward.and.arrow.up.backward.circle")?.withTintColor(.white).withRenderingMode(.automatic)
    
    let internship = Internship(title: "Супер практика", projectName: "Газпром")
    
    lazy var emailSender = EmailSenderSokrat(controller: self, internship: internship)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(pasteboardChanged), name: UIPasteboard.changedNotification, object: nil)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        checkSending()
    }
    
    
    @IBAction func classButtonPressed(_ sender: UIButton) {
        let alert = EmailSenderTesting(viewController: self)
        alert.emailSendingAlert(emailsend: true)
    }
    
    @IBAction func sokratButtonPressed(_ sender: Any) {
        
        emailSender.emailSendingAlert()
    }
    @IBAction func mailtoButtonPressed(_ sender: UIButton) {
        
        mailTo()
    }
    
    /*
    @IBAction func testAlertButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sokrat email", message: "Sokrat email pasted", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    */
    @objc func pasteboardChanged() {
        let alert = UIAlertController(title: "Sokrat email", message: "Sokrat email pasted", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        print("Email copyied")
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
        //okButton.addTarget(self, action: #selector(tryToDismiss), for: .touchUpInside)
        
        
        
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 45).isActive = true
        customView.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -10).isActive = true
        customView.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 10).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        customView.backgroundColor = .green
      
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tryToDismiss() {
        
        dismiss(animated: true, completion: nil)
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            //vc.mailComposeDelegate = self
            vc.setToRecipients(["te100ff@inbox.ru"])
            vc.setSubject("Send E mail")
            vc.setCcRecipients(["te100ff@inbox.ru"])
            vc.setMessageBody("Hello!", isHTML: true)
            present(vc, animated: true, completion: nil)
        } else {
//            guard let url = URL(string: "https://www.google.com") else {
//                return
//            }
//            let vc = SFSafariViewController(url: url)
//            present(vc, animated: true, completion: nil)
            //failedEmailSending()
        }
        
    }
    
    
    func checkSending() {
        if let url = URL(string: "mailto:te100ff@inbox.ru") {

            UIApplication.shared.open(url, options: [:]) { success in
                if success {
                    print("YES")
                } else {
                    self.failedEmailSending()
                }
            }
        }
        
    }
    
   
       

    
    func failedEmailSending() {

        let alert = UIAlertController(title: "Ошибка", message: "Отправка не удалась. Попробовать ещё раз?", preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = .light
        let cancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        let repeatSending = UIAlertAction(title: "Ещё раз", style: .default) { _ in
            self.tryToDismiss()
        }
        let share = UIAlertAction(title: "Share", style: .default) { _ in
            self.sharingButton()
        }

        alert.addAction(repeatSending)
        alert.addAction(share)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)


       }

    func sharingButton() {

        //let image = UIImage(systemName: "arrow.down.forward.and.arrow.up.backward.circle")?.withTintColor(.white).withRenderingMode(.alwaysOriginal)
        let avatarImage = UIImage(named: "Avatar")
        let image60 = UIImage(named: "60")
        let text = "Hello!"


        let items = [text]


        let firstItem = """
        Хочу пройти практику
        такую-то у "Супер корпорация"
        Тим Кук
        """
        let secondItem = UIImage(systemName: "arrow.down.forward.and.arrow.up.backward.circle")
        let thirdItem = "Text3"
        let fourth = URL(string: "https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html")

        let activityVC = UIActivityViewController(activityItems: [self], applicationActivities: nil)


        activityVC.excludedActivityTypes = [.airDrop, .addToReadingList, .message, .assignToContact, .markupAsPDF, .openInIBooks, .postToFacebook, .postToVimeo]
        //activityVC.setValue("Хочу на практику", forKey: "subject")


        present(activityVC, animated: true, completion: nil)



    }
//
//    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
//        return "activityViewController"
//    }
//
//    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
//        return "Check 2"
//    }
//
//    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
//        "Subject check"
//    }
//
//
//    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivity.ActivityType?, suggestedSize size: CGSize) -> UIImage? {
//
//        return image
//    }
//
//
//
////    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?) -> String {
////
////    }
    
    private func mailTo() {
        
        let address = "te100ff@inbox.ru"
        let subject = "Practice subject"

        // Example email body with useful info for bug reports
        let body = "Practice"

        // Build the URL from its components
        var components = URLComponents()
        components.scheme = "mailto"
        components.path = address
        components.queryItems = [
              URLQueryItem(name: "subject", value: subject),
              URLQueryItem(name: "body", value: body)
        ]

        guard let url = components.url else {
            NSLog("Failed to create mailto URL")
            return
        }

        UIApplication.shared.open(url) { success in
            switch success {
                
            case true:
                print("true")
            case false:
                print("false")
            }
        }
        
    }
        
    }
    
    
//
//extension ViewController: UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
//
//
//}

extension ViewController {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled, .failed:
            controller.dismiss(animated: true, completion: { self.emailSender.failedEmailSending() } )
        case .saved:
            controller.dismiss(animated: true, completion: nil )
        case .sent:
            self.emailSender.addSuccessButton()
            controller.dismiss(animated: true, completion: { self.emailSender.presentAlert() } )
        @unknown default:
            break
        }
                
    }
    
   
}


