//
//  RoverPostcardMakerViewController.swift
//  NASApp
//
//  Created by Michele Mola on 07/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import Kingfisher
import MessageUI

class RoverPostcardMakerViewController: UIViewController {
  
  var marsRover: MarsRover?
  
  @IBOutlet weak var marsImageView: UIImageView!
  @IBOutlet weak var messageTextField: UITextField!
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  func setupView() {
    
    if let marsRover = marsRover {
      
      // Set image in imageView with the Kingfisher library
      marsImageView.kf.setImage(with: marsRover.img_src, placeholder: UIImage(named: "placeholder.png"))
    }
    
    // Register notification observers
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  @objc func keyboardWillShow(notification:NSNotification) {
    
    var userInfo = notification.userInfo!
    var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    
    // Get keyboard frame
    keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    
    var contentInset:UIEdgeInsets = self.scrollView.contentInset
    contentInset.bottom = keyboardFrame.size.height
    
    DispatchQueue.main.async {
      // Animate re-position
      UIView.animate(withDuration: 0.8, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
        // Re-position content in scrollView
        self.scrollView.contentInset = contentInset
      }, completion: nil)
    }
    
  }
  
  @objc func keyboardWillHide(notification:NSNotification) {
    
    let contentInset:UIEdgeInsets = UIEdgeInsets.zero
    
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
        // Reset scrollView content
        self.scrollView.contentInset = contentInset
      }, completion: nil)
    }
  }
    
  
  @IBAction func pressedAddText(_ sender: UIButton) {
    if let text = messageTextField.text, let image = marsImageView.image {
      
      // Add text to image
      let imageWithText = textToImage(drawText: text, inImage: image, atPoint: CGPoint(x: 10, y: 10))
      
      // Set new image with text in imageView
      marsImageView.image = imageWithText
    }
  }
  
  
  @IBAction func pressedSendEmail(_ sender: UIButton) {
    if let image = marsImageView.image {
      self.sendMail(withImage: image)
    }
  }
  
  func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
    let textColor = UIColor.white
    let textFont = UIFont(name: "Helvetica Bold", size: 44)!
    
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
    
    let textFontAttributes = [
      NSAttributedString.Key.font: textFont,
      NSAttributedString.Key.foregroundColor: textColor,
      ] as [NSAttributedString.Key : Any]
    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    
    let rect = CGRect(origin: point, size: image.size)
    text.draw(in: rect, withAttributes: textFontAttributes)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
  
  func sendMail(withImage image: UIImage) {
    if MFMailComposeViewController.canSendMail() {
      let mail = MFMailComposeViewController()
      mail.mailComposeDelegate = self
      
      // Default default recipient
      mail.setToRecipients(["michele.mola92@gmail.com"])
      
      mail.setSubject("Your postcard")
      mail.setMessageBody("Mars rover postcard", isHTML: false)
      
      // Convert image to data
      if let data = image.jpegData(compressionQuality: 1.0) {
        mail.addAttachmentData(data, mimeType: "image/jpeg", fileName: "marsRoverPostcard.jpeg")
        self.present(mail, animated: true, completion: nil)
      }
    } else {
      print("Device cannot send email")
    }
  }
  
}

extension RoverPostcardMakerViewController: MFMailComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
}
