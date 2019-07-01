//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by MacOS on 3/8/19.
//  Copyright © 2019 MacOS. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , MFMailComposeViewControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        
        
        guard let image = imageView.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        
        activityController.popoverPresentationController?.sourceView = sender
        
        present(activityController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func safariButtonPressed(_ sender: UIButton) {
        
        if let url = URL(string: "http://www.apple.com"){
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion:  nil)
        }
        
        
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        
        
       
        
        
        
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Sourse", message: nil, preferredStyle: .actionSheet)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in
            
            imagePicker.sourceType = .camera
            self.present(imagePicker,animated: true, completion: nil)
        })
            alertController.addAction(cameraAction)
            
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {action in
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker,animated: true, completion: nil)
        })
         alertController.addAction(photoLibraryAction)
        }
        
       
        alertController.addAction(cancelAction)
       
        
        //alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated:  true, completion:  nil)
        
        
        
    }
    
    
    func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    @IBAction func emailButtonPressed(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Can not send mail")
            return
        }
        let mailComposer = MFMailComposeViewController()
        
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setToRecipients(["example@example.com"])
        mailComposer.setSubject("Look at this")
        mailComposer.setMessageBody("Hello, this is an email from the app I made", isHTML: false)
        
        
        present(mailComposer, animated: true, completion:  nil)
        
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
        dismiss(animated: true, completion: nil)
    }
    
    
    

}

