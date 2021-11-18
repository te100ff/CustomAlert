//
//  ViewController.swift
//  CustomAlert
//
//  Created by Stanislav Testov on 23.10.2021.
//

import UIKit
import MessageUI
import SafariServices

class ViewController: UIViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, UIActivityItemSource {
    
    
    private let image = UIImage(systemName: "arrow.down.forward.and.arrow.up.backward.circle")?.withTintColor(.white).withRenderingMode(.automatic)
    
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
      
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tryToDismiss() {
        
        dismiss(animated: true, completion: nil)
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.mailComposeDelegate = self
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
            failedemailSending()
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            self.dismiss(animated: true) {
                self.failedemailSending()
            }
            //failedemailSending()
            print("Email canceled")
        case .saved:
            print("Email saved")
        case .sent:
            failedemailSending()
            print("Email SENT")
        case .failed:
            failedemailSending()
            print("Email sending failed")
        @unknown default:
            fatalError()
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    

    
    func failedemailSending() {
        
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
        
       
//        let firstItem = """
//        Хочу пройти практику
//        такую-то у "Супер корпорация"
//        Тим Кук
//        """
       // let secondItem = UIImage(systemName: "arrow.down.forward.and.arrow.up.backward.circle")
//        let thirdItem = "Text3"
//        let fourth = URL(string: "https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html")
        
        let activityVC = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        
        
        activityVC.excludedActivityTypes = [.airDrop, .addToReadingList, .message, .assignToContact, .markupAsPDF, .openInIBooks, .postToFacebook, .postToVimeo]
        //activityVC.setValue("Хочу на практику", forKey: "subject")
        
        
        present(activityVC, animated: true, completion: nil)
        
        
        
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "activityViewController"
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return "Check 2"
    }

    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        "Subject check"
    }
    
    
    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivity.ActivityType?, suggestedSize size: CGSize) -> UIImage? {

        return image
    }
    
    
    
//    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?) -> String {
//        <#code#>
//    }
        
    }
    
    


