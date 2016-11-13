//
//  SearchResultViewController.swift
//  omotenashiApp
//
//  Created by sho on 2016/10/25.
//  Copyright © 2016年 TMT. All rights reserved.
//

import UIKit
import CoreLocation

class SearchResultViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var distanceCircleRotation: UIImageView!
    
    @IBOutlet weak var directionDisplay: UITextField!
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
            super.viewDidLoad()
        
//        /*--------------------------------
//         * 距離と方角の円盤を回転させる
//         ---------------------------------*/
//        //角度計算
//        let angle:CGFloat = CGFloat((270.0 * M_PI) / 180.0)
//        //回転するためのアフィン変換
//        distanceCircleRotation.transform = CGAffineTransformMakeRotation(angle)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            
            // 何度動いたら更新するか（デフォルトは1度）
            locationManager.headingFilter = kCLHeadingFilterNone
            
            // デバイスのどの向きを北とするか（デフォルトは画面上部）
            locationManager.headingOrientation = .Portrait
            
            locationManager.startUpdatingHeading()
        }

        
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
    
    //ユーザーに位置情報の使用を許可しているか確認
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .Restricted, .Denied:
            break
        case .Authorized, .AuthorizedWhenInUse:
            break
        }
    }
    
    //　iPhoneの向きが変わると呼ばれる
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //角度を表示
        self.directionDisplay.text = "".stringByAppendingFormat("%.2f", newHeading.magneticHeading)
        //角度をラジアンに変換して回転
        distanceCircleRotation.transform = CGAffineTransformMakeRotation( CGFloat(-newHeading.trueHeading * M_PI/180))

    }

}
