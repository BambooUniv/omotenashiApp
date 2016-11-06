//
//  MainViewController.swift
//  omotenashiApp
//
//  Created by sho on 2016/10/25.
//  Copyright © 2016年 TMT. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {
  
    var locationManager: CLLocationManager!
    var latitude: Double!
    var longitude: Double!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // 位置情報の取得を許可しているか確認
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.Restricted || status == CLAuthorizationStatus.Denied {
          return
        }
      
        locationManager = CLLocationManager()
        locationManager.delegate = self
        if (status == CLAuthorizationStatus.NotDetermined) {
          locationManager.requestWhenInUseAuthorization()
        }
        if !CLLocationManager.locationServicesEnabled() {
          return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
      

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  @IBAction func locationButton(sender: AnyObject) {
    let userDefault = NSUserDefaults.standardUserDefaults()
    let userInfo = userDefault.objectForKey("userInfo") as? [String: String]
    let userId: String! = userInfo!["id"]
    Help.sendHelpWithType(userId, content: "location", latitude: self.latitude, longitude: self.longitude)
  }
  @IBAction func toiletButton(sender: AnyObject) {
    let userDefault = NSUserDefaults.standardUserDefaults()
    let userInfo = userDefault.objectForKey("userInfo") as? [String: String]
    let userId: String! = userInfo!["id"]
    Help.sendHelpWithType(userId, content: "toilet", latitude: self.latitude, longitude: self.longitude)
  }
  @IBAction func sickButton(sender: AnyObject) {
    let userDefault = NSUserDefaults.standardUserDefaults()
    let userInfo = userDefault.objectForKey("userInfo") as? [String: String]
    let userId: String! = userInfo!["id"]
    Help.sendHelpWithType(userId, content: "sick", latitude: self.latitude, longitude: self.longitude)
  }
  @IBAction func mealButton(sender: AnyObject) {
    let userDefault = NSUserDefaults.standardUserDefaults()
    let userInfo = userDefault.objectForKey("userInfo") as? [String: String]
    let userId: String! = userInfo!["id"]
    Help.sendHelpWithType(userId, content: "meal", latitude: self.latitude, longitude: self.longitude)
  }
  
  
  /*--------------------------------------
   * 位置情報関係のDelegate
   *-------------------------------------*/
  // 現在値が更新されるたびに呼び出される関数
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = manager.location {
      self.latitude = location.coordinate.latitude
      self.longitude = location.coordinate.longitude
    }
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print("error")
  }
}
