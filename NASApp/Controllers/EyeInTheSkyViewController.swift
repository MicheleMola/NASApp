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
      
      geoCoder.geocodeAddressString(streetAddress) { (placemarks, error) in
        guard let placemarks = placemarks, let location = placemarks.first?.location else {
          return
        }
        
        self.latitudeTextField.text = "\(location.coordinate.latitude)"
        self.longitudeTextField.text = "\(location.coordinate.longitude)"
      
        self.getEarthPhoto(byCoordinate: location.coordinate)
      }
    }
  }
  
  func getEarthPhoto(byCoordinate coordinate: CLLocationCoordinate2D) {
    self.client.getEarthPhoto(byCoordinate: coordinate) { [unowned self] response in
      switch response {
      case .success(let earthPhoto):
        guard let earthPhoto = earthPhoto else { return }
        
        self.photoImageView.kf.setImage(with: earthPhoto.url, placeholder: UIImage(named: "placeholder.png"))
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  
}
