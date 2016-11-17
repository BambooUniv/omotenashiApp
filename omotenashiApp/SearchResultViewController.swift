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
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var distanceCircleRotation: UIImageView!
    
    @IBOutlet weak var directionDisplay: UITextField!
    
    /*-----------------------------------
     * お助けユーザに関する画像群
     *---------------------------------*/
    @IBOutlet weak var manInfoImageView: UIView!
    @IBOutlet weak var manImageView: UIImageView!
    @IBOutlet weak var nationalImageView: UIImageView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
   // var foreignerImageView:UIImageView!
    var foreignerDirectionString :String?
    
    var locationManager: CLLocationManager!
    
    var width:CGFloat = 0    //画像の幅
    var height:CGFloat = 0   //画像の高さ
    var imageX:CGFloat = 20   //外国人キャラクターの始点X座標
    var imageY:CGFloat = 0   //外国人キャラクターの始点Y座標
    
    var test: CGFloat = 0
    
    //表示する画像を設定する
    //let maleForeignerImage = UIImage(named: "maleForeigner")!


    override func viewDidLoad() {
            super.viewDidLoad()
        
        initImageView()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            
            // 何度動いたら更新するか（デフォルトは1度）
            locationManager.headingFilter = kCLHeadingFilterNone
            
            // デバイスのどの向きを北とするか（デフォルトは画面上部）
            locationManager.headingOrientation = .Portrait
            
            locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation() // 位置情報の取得
        }
        
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
        print(newHeading.trueHeading)
        
        self.directionDisplay.text = "".stringByAppendingFormat("%.2f", newHeading.trueHeading)
        
        //角度をラジアンに変換して回転
        distanceCircleRotation.transform = CGAffineTransformMakeRotation( CGFloat(-newHeading.trueHeading * M_PI/180))
        
        if (self.foreignerDirectionString == nil) {
            let activeHelpInfo = Help.getActiveHelpInfo()
            let foreignerDirection = activeHelpInfo["direction"]   //ユーザーから見た外国人のいる北からの角度
            foreignerDirectionString = String(foreignerDirection!)
        }
        
        
        self.wrapperView.layer.anchorPoint = CGPointMake(0.5, 0.5)
        self.wrapperView.transform = CGAffineTransformMakeRotation(CGFloat(-newHeading.trueHeading * M_PI/180))

    }
    
    
    /*--------------------------------------
     * 位置情報関係のDelegate
     *-------------------------------------*/
    // 現在値が更新されるたびに呼び出される関数
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            //ユーザーの位置
            let latitude = location.coordinate.latitude     //ユーザー緯度
            let longitude = location.coordinate.longitude   //ユーザー経度
            
            //外国人の位置
            let activeHelpInfo = Help.getActiveHelpInfo()
            let foreignerLatitude = activeHelpInfo["latitude"]     //外国人緯度
            let foreignerLongitude = activeHelpInfo["longitude"]   //外国人経度
            
            let foreignerLatitudeDouble:Double = Double(String(foreignerLatitude!))!
            let foreignerLongitudeDouble:Double = Double(String(foreignerLongitude!))!
            
            //ユーザーと外国人の位置の距離を計算
            let userLocation = CLLocation(latitude: latitude,longitude: longitude)
            let foreignerLocation = CLLocation(latitude: foreignerLatitudeDouble, longitude: foreignerLongitudeDouble)
            let distance = userLocation.distanceFromLocation(foreignerLocation)
            
            let y :CGFloat = getPointFromDistance(distance)
            self.manInfoImageView.transform = CGAffineTransformMakeTranslation(0, y)

            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
        print("error")
    }
    
    func getPointFromDistance(distance: Double) -> CGFloat {
        var distancePoint = 520 - ((520 * distance) / 300)
        if distancePoint > 365 {
            distancePoint = 365
            
        }
        
        return CGFloat(distancePoint)
    }
    
    func initImageView() {
        let activeHelpInfo = Help.getActiveHelpInfo()
        
        
    }

}
