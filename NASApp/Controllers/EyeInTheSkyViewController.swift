//
//  EyeInTheSkyViewController.swift
//  NASApp
//
//  Created by Michele Mola on 08/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import CoreLocation
import Kingfisher
import SVProgressHUD

class EyeInTheSkyViewController: UIViewController {
  
  @IBOutlet weak var streetAddressTextField: UITextField!
  @IBOutlet weak var latitudeTextField: UITextField!
  @IBOutlet weak var longitudeTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  
  let client = NASAAPIClient()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func pressedShowImage(_ sender: UIButton) {
    convertAddressToCoordinate()
  }
  
  func convertAddressToCoordinate() {
    if let streetAddress = streetAddressTextField.text {
      let geoCoder = CLGeocoder()
      
      // Get Coordinate by street address
      geoCoder.geocodeAddressString(streetAddress) { (placemarks, error) in
        guard let placemarks = placemarks, let location = placemarks.first?.location else {
          return
        }
        
        // Populate latitude and longitude textfields
        self.latitudeTextField.text = "\(location.coordinate.latitude)"
        self.longitudeTextField.text = "\(location.coordinate.longitude)"
      
        self.getEarthPhoto(byCoordinate: location.coordinate)
      }
    }
  }
  
  func getEarthPhoto(byCoordinate coordinate: CLLocationCoordinate2D) {
    // Show Spinner
    SVProgressHUD.show()
    self.client.getEarthPhoto(byCoordinate: coordinate) { [unowned self] response in
      switch response {
      case .success(let earthPhoto):
        guard let earthPhoto = earthPhoto else { return }
        
        // Set image in imageView with the Kingfisher library 
        self.photoImageView.kf.setImage(with: earthPhoto.url, placeholder: UIImage(named: "placeholder.png")) { (image, error, cacheType, imageUrl) in
          
          // Dismiss Spinner
          SVProgressHUD.dismiss()
        }
      case .failure(let error):
        print(error)
        // Dismiss Spinner
        SVProgressHUD.dismiss()
      }
    }
  }
  
  
}
