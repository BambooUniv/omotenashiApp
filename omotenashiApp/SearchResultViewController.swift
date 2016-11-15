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
    
    var foreignerImageView:UIImageView!
    
    var locationManager: CLLocationManager!
    
    var width:CGFloat = 0    //画像の幅
    var height:CGFloat = 0   //画像の高さ
    var imageX:CGFloat = 20   //外国人キャラクターの始点X座標
    var imageY:CGFloat = 0   //外国人キャラクターの始点Y座標

    override func viewDidLoad() {
            super.viewDidLoad()
        
        //ユーザーの位置
        //let userLocation = CLLocation(latitude: ,longitude: )
        
        //助けを待っている外国人の位置
        //let foreignerLocation = CLLocation(latitude: _latitude, longitude: _longitude)
        
        //ユーザーと外国人の距離
        //let distance = userLocation.distanceFromLocation(foreignerLocation)
        
        
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
            locationManager.startUpdatingLocation() // 位置情報の取得
        }
        
        /*-----------------------------------
         * キャラの絵を表示する
         ------------------------------------*/
        //表示する画像を設定する
        let maleForeignerImage = UIImage(named: "maleForeigner")!
        
        //画像の幅・高さを取得
        width = maleForeignerImage.size.width
        height = maleForeignerImage.size.height
        
        //UIImageViewインスタンス生成
        foreignerImageView = UIImageView(image:maleForeignerImage)
        
        //画像をUIImageViewに設定する
        foreignerImageView.image = maleForeignerImage
        
//        //画像サイズ・位置設定
//        let rect:CGRect = CGRectMake(imageX, imageY, width/17, height/17)
//        
//        //foreignerImageView frame をCGRectで作った短形に合わせる
//        foreignerImageView.frame = rect;
//
//        //UIImageViewをViewに追加する
//        self.view.addSubview(foreignerImageView)
        
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
    
    /*--------------------------------------
     * 位置情報関係のDelegate
     *-------------------------------------*/
    // 現在値が更新されるたびに呼び出される関数
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            //ユーザーの位置
            let latitude = location.coordinate.latitude     //ユーザー緯度
            let longitude = location.coordinate.longitude   //ユーザー経度
            
            
            print("ユーザー")
            print(latitude)
            print(longitude)
            
            //外国人の位置
            let activeHelpInfo = Help.getActiveHelpInfo()
            let foreignerLatitude = activeHelpInfo["latitude"]     //外国人緯度
            let foreignerLongitude = activeHelpInfo["longitude"]   //外国人経度
            let foreignerDirection = activeHelpInfo["direction"]   //ユーザーから見た外国人のいる北からの角度
            
            print("外国人")
            print(String(foreignerLatitude!))
            print(String(foreignerLongitude!))
            print(String(foreignerLatitude!))
            
            let foreignerLatitudeDouble:Double = Double(String(foreignerLatitude!))!
            let foreignerLongitudeDouble:Double = Double(String(foreignerLongitude!))!
            
            //ユーザーと外国人の位置の距離を計算
            let userLocation = CLLocation(latitude: latitude,longitude: longitude)
            let foreignerLocation = CLLocation(latitude: foreignerLatitudeDouble, longitude: foreignerLongitudeDouble)
            let distance = userLocation.distanceFromLocation(foreignerLocation)
            print(distance)
            
            
            
            /*---------------------------------------
             *　外国人キャラを表示
             *---------------------------------------*/
            
            let imageX: CGFloat = CGFloat(distance)
            print(imageX)
            
            //画像サイズ・位置設定
            let rect:CGRect = CGRectMake(imageX, imageY, width/17, height/17)
            
            //foreignerImageView frame をCGRectで作った短形に合わせる
            foreignerImageView.frame = rect;
            
            //UIImageViewをViewに追加する
            self.view.addSubview(foreignerImageView)

            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
        print("error")
    }

}
